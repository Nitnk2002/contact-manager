
package controller;

import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Dashboard.jsp");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String fullName = firstName+" "+lastName;
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String jobTitle = request.getParameter("jobTitle");
        
        HttpSession hs = request.getSession();
        String userEmail = (String) hs.getAttribute("user-email");
        UserModel um = new UserModel();
        UserDTO udto = new UserDTO();
        udto.setFullName(fullName);
        udto.setEmail(email);
        udto.setPhone(phone);
        udto.setJobTitle(jobTitle);
        udto.setLocation(location);
        if(um.updateUser(udto, userEmail)){
            response.sendRedirect("Dashboard.jsp");
        }else{
            System.out.println("failed to update!");
        }
        
        
    }

}
