
package dto;

import java.util.ArrayList;

/**
 *
 * @author Nitra
 */
public class UserDTO {
    
    String fullName;
    String email;
    String password;
    ArrayList<ContactDTO> contact;
    String phone;
    String jobTitle;
    String location;
    
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    public ArrayList<ContactDTO> getContact() {
        return contact;
    }

    public void setContact(ArrayList<ContactDTO> contact) {
        this.contact = contact;
    }


    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    
}
