package br.com.andtankian.endpoints.session.impl;

import br.com.andtankian.endpoints.session.interfaces.IWebSocketSessionHandler;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.Session;

/**
 *
 * @author andrew
 */
public class ConcreteWebSocketSessionHandler implements IWebSocketSessionHandler{
    
    private final Set sessions;

    public ConcreteWebSocketSessionHandler() {
        this.sessions = new HashSet();
    }

    @Override
    public synchronized void add(Session session) {
        session.setMaxIdleTimeout(-1);
        this.sessions.add(session);
    }

    @Override
    public synchronized void remove(Session session) {
        this.sessions.remove(session);
    }

    @Override
    public Set getSessions() {
        return sessions;
    }
    
    @Override
    public synchronized void notify(String message) {
        for (Object session : sessions) {
            Session s = (Session)session;
            s.getAsyncRemote().sendText(message);
        }
    }
}
