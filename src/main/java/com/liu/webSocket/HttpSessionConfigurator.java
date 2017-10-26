package com.liu.webSocket;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator{

	public void modifyHandshake(ServerEndpointConfig config,HandshakeRequest request,HandshakeResponse response){
		HttpSession httpSession=(HttpSession) request.getHttpSession();
		config.getUserProperties().put(HttpSession.class.getName(), httpSession);
	}
}
