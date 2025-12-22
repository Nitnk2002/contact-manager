/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Nitra
 */
public class DBConnection {
    
    static String url = "jdbc:mysql://localhost:3306/contactmanager";
     static String username = "root";
    static String password = "Nitnk62656@";
    
    static Connection con = null;
    static Statement st = null;
    static{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
           con=  DriverManager.getConnection(url,username,password);
           st = con.createStatement();
           System.out.println("connection Established!");
        }catch(SQLException e){
            System.out.print(e.getMessage());
        }catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static Connection getCon(){
        return con;
    }
    public static Statement getSt(){
        return st;
    }
}
