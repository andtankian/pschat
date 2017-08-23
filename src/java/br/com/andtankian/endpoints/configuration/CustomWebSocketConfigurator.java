package br.com.andtankian.endpoints.configuration;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

/**
 *
 * @author andrew
 */
public class CustomWebSocketConfigurator extends ServerEndpointConfig.Configurator{
    
    @Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        HttpSession httpSession = (HttpSession) request.getHttpSession();
        sec.getUserProperties().put("servletContext", httpSession.getServletContext());
    } 
    
}
