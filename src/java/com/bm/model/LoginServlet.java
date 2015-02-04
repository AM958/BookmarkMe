/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bm.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;
 
 
@WebServlet(name = "Login", urlPatterns = { "/Login" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    static Logger logger = Logger.getLogger(LoginServlet.class);
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String errorMsg = null;
        if(email == null || email.equals("")){
            errorMsg ="User Email can't be null or empty";
        }
        if(password == null || password.equals("")){
            errorMsg = "Password can't be null or empty";
        }
         
        if(errorMsg != null){
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/homepage.jsp");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>"+errorMsg+"</font>");
            rd.include(request, response);
        }else{
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement("select userID, username, email, verified from users where email=? and password=? limit 1");
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
             
            if(rs != null && rs.next()){

                //User user = new User(rs.getString("name"), rs.getString("email"), rs.getInt("id"));
                User user = new User(rs.getString("username"), rs.getString("email"),"Greece", rs.getInt("userID"));
                logger.info("User found with details="+user);
                HttpSession session = request.getSession();
                session.setAttribute("User", user);
                Cookie loginCookie = new Cookie("JSESSIONID",session.getId());
                loginCookie.setMaxAge(30*600); //setting cookie to expire in 300 min
                
                if(rs.getByte("verified") == 0){

                    
                    ps = con.prepareStatement("INSERT INTO collections(ownerID, privileges,name ) VALUES (?, 'Public', ?)");
                    String collName= rs.getString("username")+"'s public";
                    ps.setInt(1, rs.getInt("userID"));
                    ps.setString(2, collName);
                    ps.execute();
                    logger.info("Default Public created");
                    ps = con.prepareStatement("INSERT INTO collections(ownerID, privileges, name) VALUES (?, 'Private', 'My Private')");
                    ps.setInt(1, rs.getInt("userID"));
                    ps.execute();
                    logger.info("Default Private created");
                    ps = con.prepareStatement("UPDATE users SET verified=1 WHERE userID=?");
                    ps.setInt(1, rs.getInt("userID"));
                    ps.execute();
                    logger.info("Verified status updated");
                }
                
                response.addCookie(loginCookie); 
                response.sendRedirect("home.jsp");
            }else{
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/homepage.jsp");
                PrintWriter out= response.getWriter();
                logger.error("User not found with email="+email);
                out.println("<font color=red>No user found with given email id, please register first.</font>");
                rd.include(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Database connection problem");
            throw new ServletException("DB Connection problem.");
        }finally{
            try {
                rs.close();
                ps.close();
            } catch (SQLException e) {
                logger.error("SQLException in closing PreparedStatement or ResultSet");;
            }
             
        }
        }
    }
 
}