/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ContactModel;

/**
 *
 * @author Nitra
 */
@WebServlet(name = "DeleteContactServlet", urlPatterns = {"/DeleteContactServlet"})
public class DeleteContactServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cEmail = request.getParameter("email");
        
        ContactModel cm = new ContactModel();
        if(cm.deleteContact(cEmail)){
            response.sendRedirect("Dashboard.jsp");
        }
    }

}
