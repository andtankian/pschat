package br.com.andtankian.endpoints.session.interfaces;

import java.util.Set;
import javax.websocket.Session;

/**
 *
 * @author andrew
 */
public interface IWebSocketSessionHandler {
    
    public void add(Session session);
    public void notify(String message);
    public void remove(Session session);
    public Set getSessions();
    
}
