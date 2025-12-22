
package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import db.DBConnection;
import dto.UserDTO;
/**
 *
 * @author Nitra
 */
public class UserModel {
    
    
    public boolean registerStatus(String fullName,String email,String password){
        String query = "insert into users(fullname,email,password) values(?,?,?)";
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            int rs = ps.executeUpdate();
            System.out.println(rs);
            if(rs>0){
                return true;
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return false;
        }
        return false;
    }
    public boolean loginStatus(String email,String password){
        String query = "select password from users where email = ?";
        //System.out.println(email+password);
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            //System.out.println(rs);
            if(rs.next()){
                String tablePassword = rs.getString("password");
                if(tablePassword.equals(password)){
                    return true;
                }
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return false;
        }
        return false;
    }
    
    public UserDTO getUser(String userEmail){
        String query = "select * from users where email = ?";
        UserDTO udto = new UserDTO();
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            System.out.println(rs);
            if(rs.next()){
                String fullName = rs.getString("fullname");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String location = rs.getString("location");
                String jobTitle = rs.getString("job_title");
                udto.setFullName(fullName);
                udto.setEmail(email);
                udto.setLocation(location);
                udto.setJobTitle(jobTitle);
                udto.setPhone(phone);
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return udto;
    }
    
    public boolean updateUser(UserDTO udto,String userEmail){
        String query = "update users set fullname = ? , email = ? ,phone= ?, job_title = ?, location = ? where email = ?";
        //System.out.println(email+password);
        try{
            Connection con = DBConnection.getCon();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, udto.getFullName());
            ps.setString(2, udto.getEmail());
            ps.setString(3, udto.getPhone());
            ps.setString(4, udto.getJobTitle());
            ps.setString(5, udto.getLocation());
            ps.setString(6, userEmail);
            int row = ps.executeUpdate();
            if(row>0){
                return true;
            }else{
                return false;
            }
            
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return false;
        }
    }
        public boolean deleteAccount(String userEmail) throws SQLException{
        String uQuery = "delete from users where email = ?";
        String cQuery = "delete from contacts where user_email = ?";
        //System.out.println(email+password);
        Connection con = DBConnection.getCon();
        try{
            
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(cQuery);
            ps.setString(1, userEmail);
            ps.executeUpdate();
            
            PreparedStatement ps2 = con.prepareStatement(uQuery);
            ps2.setString(1, userEmail);
            int rowsAffected = ps2.executeUpdate();
            con.commit();
            System.out.println("Delete Successful. User rows deleted: " + rowsAffected);
            return true;
        }catch(SQLException e){
            con.rollback();
            System.out.println(e.getMessage());
            return false;
        }
    }

}
