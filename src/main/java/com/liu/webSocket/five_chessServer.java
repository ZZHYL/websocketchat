package com.liu.webSocket;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import javax.enterprise.inject.New;
import javax.security.auth.x500.X500Principal;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat.Value;

@ServerEndpoint(value="/chessServer",configurator=HttpSessionConfigurator.class)
public class five_chessServer {
	private  static int onlineCount=0;
	private static CopyOnWriteArraySet<five_chessServer> webSocket=new CopyOnWriteArraySet<five_chessServer>();
	private Session session;
	private HttpSession httpsession;
	private String userid;
	private static boolean whitechess=false;//判断白子是否可以下
	private static boolean blackchess=true;//判断黑子是否可以下
	private static List<String> list=new ArrayList<String>();//存放所有进入的用户的名称
	private  static List<String> chesss=new ArrayList<String>();//存放对局中以经下的棋子的位置用于观战
	private static Map<String, Session>routab=new HashMap<String, Session>();
	
	@OnOpen
	public void onOpen(Session session,EndpointConfig config) throws IOException
	{
		this.session=session;
		onlineCount++;
		webSocket.add(this);
		this.httpsession=(HttpSession)config.getUserProperties().get(HttpSession.class.getName());
		this.userid=(String) httpsession.getAttribute("userid");//获取访问的session的用户Id
		list.add(userid);
		routab.put(userid,session);
		//如果是观战的用户，将未来之前所下的棋子展示
		if(list.size()>2)
			{
			if(userid!=list.get(0)&&userid!=list.get(1))
			{
				for(int i=0;i<chesss.size();i++)
				{
					sendxy(chesss.get(i), routab.get(userid));
				}
			}
			}
	}
	@OnClose
	public void onClose()
	{
		String closemessage;
		//如果是下棋者离开，下棋顺序恢复
		if(list.size()>1)
		{
			if(userid.equals(list.get(1))||userid.equals(list.get(0)))
			{
				whitechess=false;
				blackchess=true;
				chesss.clear();
			}
		}
		webSocket.remove(this);
		onlineCount--;
		list.remove(userid);
		routab.remove(userid);
		closemessage=getMessage("[" + userid +"]退出，当前在线人数为"+onlineCount+"位", "tishi",list);
//		发送提示信息
		broadcast(closemessage);
	}
	@OnMessage
	public void onMessage(String _message) throws IOException
	{

		String message1;
		JSONObject message=JSONObject.parseObject(_message);//解析前台发来的json
		if(message.get("type").toString().equals("tishi"))//如果type为提示，则广播信息
		{
			if(onlineCount==1)
			{
			 message1=getMessage("[" + userid +"]加入五子棋，当前在线人数为"+onlineCount+"位,请等待另一位加入", "tishi",list);
			}
			else if(onlineCount==2)
			{
			message1=getMessage("[" + userid +"]加入五子棋，当前在线人数为"+onlineCount+"位,游戏开始", "tishi",list);
			}
			else {
				
			message1=getMessage("[" + userid +"]加入五子棋观战，当前在线人数为"+onlineCount+"位", "tishi",list);
			}
			broadcast(message1);
		}
//		如果发来的type为坐标
		if(message.get("type").toString().equals("zuobiaoxy"))
		{
		String zuobiao=message.get("zuobiao").toString();//获取
//		如果当前可下的是白棋，并且是第一个用户下的则画棋给所有人
		if(whitechess&&userid.equals(list.get(0)))
		{
			for(String user:list)
			{
					sendxy(_message,routab.get(user));
			}
			chesss.add(_message);
			whitechess=false;//下棋顺序进行切换
			blackchess=true;
		}
		if(list.size()>1)
		{
//			与上相反
		if(blackchess&&userid.equals(list.get(1)))
		{
			for(String user:list)
			{

					sendxy(_message,routab.get(user));
					
			}
			chesss.add(_message);
			whitechess=true;
			blackchess=false;
		}
		}
		}
	
	}
	@OnError
	public void onError(Throwable error){
		error.printStackTrace();
	}
	public void sendxy(String xymessage,Session session) throws IOException
	{
		session.getBasicRemote().sendText(xymessage);
	}
	public String getMessage(String message,String type,List list)
	{
		JSONObject member=new JSONObject();
		member.put("message", message);
		member.put("type", type);
		member.put("list", list);
		return member.toString();
	}
	public void broadcast(String message)//广播信息
	{
		for(five_chessServer chat:webSocket){
			try{
				  chat.session.getBasicRemote().sendText(message);//按照session发送信息
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
