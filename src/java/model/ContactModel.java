
package model;

import db.DBConnection;
import dto.ContactDTO;
import dto.UserDTO;
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
/**
 *
 * @author Nitra
 */
public class ContactModel {
    
    public ArrayList<ContactDTO> contactList(String userEmail){
        String query = "select * from contacts where user_email = ? ";
        ArrayList<ContactDTO> list = new ArrayList<>();
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,userEmail);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                String fullName = rs.getString("fullname");
                String jobTitle = rs.getString("job_title");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                ContactDTO condto = new ContactDTO();
                condto.setFullName(fullName);
                condto.setJobTitle(jobTitle);
                condto.setEmail(email);
                condto.setPhone(phone);
                list.add(condto);
            }
           
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public boolean addContact(ContactDTO cdto,String userEmail){
        String query = "INSERT INTO contacts (user_email, fullname,job_title, email, phone ) VALUES (?, ?, ?, ?, ?)";
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,userEmail);
            ps.setString(2,cdto.getFullName());
            ps.setString(3,cdto.getJobTitle());
            ps.setString(4,cdto.getEmail());
            ps.setString(5,cdto.getPhone());
            int row = ps.executeUpdate();
            if(row>0){
                System.out.println("contact added!");
                return true;
            }else{
                System.out.println("failed to add contact!");
                return false;
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return false;
    }
        public boolean deleteContact(String cEmail){
        String query = "delete from contacts where email= ?";
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,cEmail);
            int row = ps.executeUpdate();
            if(row>0){
                System.out.println("contact deleted!");
                return true;
            }else{
                System.out.println("failed to delete contact!");
                return false;
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return false;
    }
}
