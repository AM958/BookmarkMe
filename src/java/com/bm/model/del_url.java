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
 
 
@WebServlet(name = "del_url", urlPatterns = { "/del_url" })
public class del_url extends HttpServlet {
     
    static Logger logger = Logger.getLogger(new_url.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        String colid = request.getParameter("collid");
        String urlid = request.getParameter("urlid");
        String jsp = request.getParameter("jsp");
        String errorMsg = null;
        if(colid.equals("") || uid.equals("") || urlid.equals("") || jsp.equals("")){
            errorMsg ="There was an error when trying to delete this url, try again!";
        }         
        if(errorMsg != null){
            request.setAttribute("ReqError","Error! "+errorMsg); 
            RequestDispatcher rd = getServletContext().getRequestDispatcher(jsp);
            rd.include(request, response);
        }else{
        
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement("DELETE FROM urls WHERE ownerID=? AND collectionID=? AND urlID=?");
            ps.setString(1, uid);
            ps.setString(2, colid);
            ps.setString(3, urlid);
            ps.execute();
            logger.info("Query executed"+uid+colid+urlid);
            //request.setAttribute("ReqSuccess","URL was successfully deleted!"); 
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