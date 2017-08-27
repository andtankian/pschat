package br.com.andtankian.endpoints.servlets;

import br.com.andtankian.endpoints.session.interfaces.IWebSocketSessionHandler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author andrew
 */
@WebServlet(name = "SendMessageServlet", urlPatterns = {"/talk/private/secure/chat/send"})
public class SendMessageServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IWebSocketSessionHandler handler = (IWebSocketSessionHandler) req.getServletContext().getAttribute("pschatrealtime");
        
        String who = req.getParameter("chatter");
        String message = req.getParameter("message");
        StringBuilder sb = new StringBuilder("{\"chatter\":\"");
        sb.append(who).append("\", \"message\":\"")
                .append(message).append("\"}");
        
        handler.notify(sb.toString());        
        
    }
    
    
}
