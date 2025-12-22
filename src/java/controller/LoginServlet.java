/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserModel;

/**
 *
 * @author Nitra
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("login.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession hs = request.getSession(true);
        //System.out.println(email+password);
        UserDTO userdto = new UserDTO();
        userdto.setEmail(email);
        userdto.setPassword(password);
        UserModel user = new UserModel();
        hs.setAttribute("user-email", userdto.getEmail());
        if(user.loginStatus(userdto.getEmail(),userdto.getPassword())){
            response.sendRedirect("Dashboard.jsp");
        }else{
            response.sendRedirect("login.html?error=true");
            System.out.println("login Failed!");
        }
    }
}
