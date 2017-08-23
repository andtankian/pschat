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
@WebServlet(name = "SecurityQuestionServlet", urlPatterns = {"/talk/private/secure/chat"})
public class SecurityQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String sq = (String) req.getServletContext().getAttribute("sq");
        if(sq == null || sq.isEmpty()) {
            resp.sendRedirect("/pschat/automaticrender/registersqandsa");
        } else {
            String sessionsa = (String) req.getSession().getAttribute("sa");
            if(sessionsa == null || sessionsa.isEmpty()){
                resp.sendRedirect("/pschat/automaticrender/answersa");
            } else {
                req.getRequestDispatcher("/pschat.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String sq, sa;
        sq = req.getParameter("sq");
        sa = req.getParameter("sa");
        
        boolean isValid = true;
        
        String status, message;
        status = message = "";
        if(sq==null || sq.isEmpty()){
            isValid = false;
            status = "-1";
            message = "Pergunta de segurança está vazia.";
        }
        
        if(sa == null || sa.isEmpty()){
            isValid = false;
            status = "-1";
            message+= "| Resposta de segurança está vazia.";
        }
        
        if(isValid){
            req.getServletContext().setAttribute("sq", sq);
            req.getServletContext().setAttribute("sa", sa);
            status = "1";
            message = "ok";
        }
        
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().print(new StringBuilder("{\"")
                .append("status\":")
                .append(status)
                .append(",\"message\":\"")
                .append(message)
                .append("\"}"));
        
        
    }
    
    

    

}
