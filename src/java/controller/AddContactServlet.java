/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.ContactDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ContactModel;

/**
 *
 * @author Nitra
 */
@WebServlet(name = "AddContactServlet", urlPatterns = {"/AddContactServlet"})
public class AddContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String jobTitle = request.getParameter("jobTitle");
        String emailAddress = request.getParameter("email");
        String phoneno = request.getParameter("phone");
        HttpSession  hs = request.getSession();
        String userEmail = (String) hs.getAttribute("user-email");
        ContactDTO contact = new ContactDTO();
        contact.setEmail(emailAddress);
        contact.setFullName(fullName);
        contact.setJobTitle(jobTitle);
        contact.setPhone(phoneno);
        ContactModel cm = new ContactModel();
        if(cm.addContact(contact,userEmail)){
            System.out.println("added contact");
            response.sendRedirect("Dashboard.jsp");
        }else{
            response.getWriter().println("Error: Contact not saved.");
            System.out.println("failed to add contact!");
        }
    }


}
