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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;
 
 
@WebServlet(name = "new_url", urlPatterns = { "/new_url" })
public class new_url extends HttpServlet {
     
    static Logger logger = Logger.getLogger(new_url.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newUrl = request.getParameter("name");
        String description = request.getParameter("descr");
        String uid = request.getParameter("uid");
        String colid = request.getParameter("colid");
        String jsp = request.getParameter("jsp");
        String errorMsg = null;
        if(newUrl.equals("") || description.equals("")){
            errorMsg ="URL or Description can't be empty!";
        }         
        if(errorMsg != null){
            request.setAttribute("ReqError","Error! "+errorMsg); 
            RequestDispatcher rd = getServletContext().getRequestDispatcher(jsp);
            rd.include(request, response);
        }else{
         
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement("insert into urls(url, collectionID, ownerID, description) values (?, ?, ?, ?)");
            ps.setString(1, newUrl);
            ps.setString(2, colid);
            ps.setString(3, uid);
            ps.setString(4, description);
            ps.execute();
            request.setAttribute("ReqSuccess","URL was successfully added!");  
            RequestDispatcher rd = getServletContext().getRequestDispatcher(jsp);
            rd.include(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Database connection problem");
            throw new ServletException("DB Connection problem.");
        }finally{
            try {
                ps.close();
            } catch (SQLException e) {
                logger.error("SQLException in closing PreparedStatement or ResultSet");;
            }
             
        }
        }
    }
 
}