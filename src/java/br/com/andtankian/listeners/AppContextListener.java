package br.com.andtankian.listeners;

import br.com.andtankian.endpoints.session.impl.ConcreteWebSocketSessionHandler;
import java.util.HashSet;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 *
 * @author andrew
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("pschatrealtime", new ConcreteWebSocketSessionHandler());
        sce.getServletContext().setAttribute("chatters", new HashSet());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
    
}
