
package dto;

/**
 *
 * @author Nitra
 */
public class ContactDTO {
    
    String fullName;
    String jobTitle;
    String email;
    String phone;
    
    public String getFullName() {
            return fullName;
       }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
