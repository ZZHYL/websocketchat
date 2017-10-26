package com.liu.webSocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.alibaba.fastjson.JSONObject;

@ServerEndpoint(value="/chatServer",configurator=HttpSessionConfigurator.class)
public class ChatServer{
	private static int onlineCount=0;	//统计在线人数
	private static CopyOnWriteArraySet<ChatServer> webSocket=new CopyOnWriteArraySet<ChatServer>();//存放每个Server设置为线程安全
	private Session session;
	private String userid;//用户Id
	private HttpSession httpSession;
	private static List<Object> list=new ArrayList<Object>();//存放每个用户id
	private static Map<String,Session> routetab=new HashMap<String,Session>();//存放session
	@OnOpen
	public void onOpen(Session session,EndpointConfig config)//连接时调用此函数
	{
		this.session=session;
		webSocket.add(this);         //添加此Server      
		addOnlineCount();	//在线人数加1；
		this.httpSession=(HttpSession) config.getUserProperties().get(HttpSession.class.getName());//获取此Server的httpSession
		this.userid=(String) httpSession.getAttribute("userid");//获取用户Id
		System.out.println("userid:"+userid);
		list.add(userid);//添加到list
		routetab.put(userid, session);//把session按用户Id存放到map中
		String message=getMessage("[" + userid + "]加入聊天室,当前在线人数为"+getOnlineCount()+"位", "notice",  list);//获取广播的语句格式
		broadcast(message);//广播提示语句
	}
	@OnClose
	public void onClose(){//关闭时调用
		webSocket.remove(this);//移除次Server
		subOnlineCount();     //人数减一
		list.remove(userid);//移除次用户id
		routetab.remove(userid);//移除MAP中的次用户
		String message=getMessage("[" + userid +"]离开了聊天室,当前在线人数为"+getOnlineCount()+"位", "notice", list);
		broadcast(message);//广播
	}
	@OnMessage
	public void onMessage(String _message)//接受到数据时调用
	{
		JSONObject chat=JSONObject.parseObject(_message);//解析次JSON为对象
		JSONObject message=JSONObject.parseObject(chat.get("message").toString());//获取message中的数据
		if(message.get("to")==null||message.get("to").toString().equals("")){//如果发送的人为空，则进行广播
			broadcast(_message);
		}else
		{
			String [] userlist=message.get("to").toString().split(",");//获取要发送的名称
			singleSend(_message,(Session)routetab.get(message.get("from")));//发送给自己
			for(String user:userlist)//按用户进行发送
			{
				if(!user.equals(message.get("from")))
				{
					singleSend(_message,(Session)routetab.get(user));//发送信息给指定用户
				}
			}
		}
	}
	@OnError
	public void onError(Throwable error){
		error.printStackTrace();
	}
	public void broadcast(String message)//广播信息
	{
		for(ChatServer chat:webSocket){
			try{
				  chat.session.getBasicRemote().sendText(message);
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	  public void singleSend(String message, Session session){
	        try {
	            session.getBasicRemote().sendText(message);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	public String getMessage(String message,String type,List list)
	{
		JSONObject member=new JSONObject();
		member.put("message", message);
		member.put("type", type);
		member.put("list", list);
		return member.toString();
	}
	  public  int getOnlineCount() {
	        return onlineCount;
	    }

	    public  void addOnlineCount() {
	        ChatServer.onlineCount++;
	    }

	    public  void subOnlineCount() {
	        ChatServer.onlineCount--;
	    }
}
