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
@WebServlet(name = "AutomaticRenderServlet", urlPatterns = {"/automaticrender/*"})
public class AutomaticRenderServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String pathInfo = req.getPathInfo();
        pathInfo = pathInfo == null || pathInfo.isEmpty() ? "" : pathInfo;
        
        System.out.println(pathInfo);
        if(pathInfo.isEmpty()) resp.sendError(404);
        req.getRequestDispatcher(new StringBuilder(pathInfo).append(".jsp").toString()).forward(req, resp);
    }
    
    
    
}
