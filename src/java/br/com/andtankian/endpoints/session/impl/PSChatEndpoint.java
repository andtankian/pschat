package br.com.andtankian.endpoints.session.impl;

import br.com.andtankian.endpoints.configuration.CustomWebSocketConfigurator;
import br.com.andtankian.endpoints.session.interfaces.IWebSocketSessionHandler;
import javax.servlet.ServletContext;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author andrew
 */
@ServerEndpoint(value = "/talk/private/secure/chat", configurator = CustomWebSocketConfigurator.class)
public class PSChatEndpoint {

    private EndpointConfig config;
    private ServletContext app;
    private IWebSocketSessionHandler handler;

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        this.config = config;
        app = (ServletContext) config.getUserProperties().get("servletContext");
        handler = (IWebSocketSessionHandler) app.getAttribute("pschatrealtime");
        handler.add(session);
    }

    @OnClose
    public void onClose(Session session) {
        handler.remove(session);
    }

    @OnError
    public void onError(Session session, Throwable t) {
        /* Remove this connection from the queue */
        handler.remove(session);
        System.out.println(t.getCause().getMessage());
    }

}
