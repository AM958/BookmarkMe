/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bm.filters;

import java.io.IOException;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;
import com.bm.model.User;
import javax.servlet.http.Cookie;
 
@WebFilter("/AuthenticationFilter")
public class AuthenticationFilter implements Filter {
 
    private Logger logger = Logger.getLogger(AuthenticationFilter.class);
     
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        logger.info("AuthenticationFilter initialized");
    }
     
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
 
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
         
        String uri = req.getRequestURI();
        logger.info("Requested Resource::"+uri);
         
        HttpSession session = req.getSession(false);
        logger.info("Session::"+session); 
        if(session == null && !(uri.endsWith("html") || uri.endsWith("Login") || uri.endsWith("Register") || (uri.endsWith("me") ) || (uri.endsWith("css") ) || (uri.endsWith("png") ) || (uri.endsWith("jpg") ))){
            logger.error("Unauthorized access request");
            res.sendRedirect("bookmark.me");
        }
        else if(session != null && !(uri.endsWith("html") || uri.endsWith("Login") || uri.endsWith("gif") || uri.endsWith("Register") || (uri.endsWith("me") ) || (uri.endsWith("css") ) || (uri.endsWith("png") ) || (uri.endsWith("jpg") ))){
            // pass the request along the filter chain
            
            if(session.getAttribute("User") == null){
                res.sendRedirect("bookmark.me");
            }
            else {

                User user = (User) session.getAttribute("User");
                if(user.getName() == null){
                    res.sendRedirect("bookmark.me");
                }
                else{
                    chain.doFilter(request, response);
                }
            }
        }
        else{
                chain.doFilter(request, response);
        
        }
         
         
    }
 
    @Override
    public void destroy() {
        //close any resources here
    }
 
}