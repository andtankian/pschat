package br.com.andtankian.filters.impl;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author andrew
 */
@WebFilter(filterName = "DontAllowJSPDirectAccessFilter", urlPatterns = {"*.jsp"}, dispatcherTypes = {DispatcherType.REQUEST})
public class DontAllowJSPDirectAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        HttpServletResponse httpresp = (HttpServletResponse)response;
        httpresp.sendError(403);
    }

    @Override
    public void destroy() {
        
    }
    
    
    
}
