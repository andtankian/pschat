package br.com.andtankian.endpoints.servlets;

import java.io.IOException;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author andrew
 */
@WebServlet(name = "RetrieveBasicChattersInfoServlet", urlPatterns = {"/chatters"})
public class RetrieveBasicChattersInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        StringBuilder sb = new StringBuilder("{\"chatters\": [");

        Set chatters = (Set) req.getServletContext().getAttribute("chatters");

        for (Object chatter : chatters) {

            sb.append("{\"nickname\":\"")
                    .append(chatter)
                    .append("\"},");

        }
        
        sb.delete(sb.length() - 1, sb.length());
        sb.append("], \"status\": 1}");
        resp.getWriter().print(sb.toString());
    }

}
