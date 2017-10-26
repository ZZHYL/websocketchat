package com.liu.webSocket;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.*;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/videoServer",configurator=HttpSessionConfigurator.class)
public class VideoServer {
	private static final int MAX_CONNECTION=20;
	private static final int MAX_TIMEOUT=2*60*1000;
	private static final Map<String, String>usermap=Collections.synchronizedMap(new HashMap<String, String>());
	private static final Map<String, Session> sessions = Collections.synchronizedMap(new HashMap<String, Session>());
	@OnOpen
	public void onOpen(Session session)
	{
		System.out.println("onOpen");
	}
	@OnMessage
	public void OnMessage(String message,Session session)
	{
		
	}
	@OnClose
	public void onClose(Session session)
	{
		
	}
	@OnError
	public void onError(Throwable error)
	{
	  error.printStackTrace();
	}
}
