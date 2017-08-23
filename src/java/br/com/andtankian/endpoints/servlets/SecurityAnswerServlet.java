package br.com.andtankian.endpoints.servlets;

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
@WebServlet(name = "SecurityAnswerServlet", urlPatterns = {"/wannaanswer"})
public class SecurityAnswerServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("utf-8");
        String sa = req.getParameter("sa");
        
        String message, status;
        message = status = "";
        if(sa == null || sa.isEmpty()){
            message = "Resposta secreta inválida.";
            status = "-1";
        } else {
            String realsa = (String) req.getServletContext().getAttribute("sa");
            if(sa.equalsIgnoreCase(realsa)){
                /*Authenticated*/
                message = "Resposta correta.";
                status = "1";
                req.getSession().invalidate();
                req.getSession(true).setAttribute("sa", "authenticated");
            } else {
                /*Authenticated*/
                message = "Resposta secreta errada.";
                status = "-2";
            }
        }
        
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().print(new StringBuilder("{\"")
        .append("status\":")
        .append(status)
        .append(", \"message\":")
        .append("\"")
        .append(message)
        .append("\"}"));
    }
    
    
    
}
