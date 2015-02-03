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
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.log4j.Logger;
 
 
@WebServlet(name = "new_collection", urlPatterns = { "/new_collection" })
public class new_collection extends HttpServlet {
     
    static Logger logger = Logger.getLogger(new_url.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String privileges = request.getParameter("privileges");
        String uid = request.getParameter("uid");
        String jsp = request.getParameter("jsp");
        String errorMsg = null;
        if(name.equals("")){
            errorMsg ="Collection name can't be empty!";
        }         
        if(errorMsg != null){
            request.setAttribute("ReqError","Error! "+errorMsg); 
            RequestDispatcher rd = getServletContext().getRequestDispatcher(jsp);
            rd.include(request, response);
        }else{
         
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement("INSERT INTO collections(name, privileges, ownerID) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, privileges);
            ps.setString(3, uid);
            ps.execute();
            //request.setAttribute("ReqSuccess","Collection was successfully added!");  
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