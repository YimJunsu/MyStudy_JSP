package dto;

public class Member {
    private String id;
    private String password;
    private String name;
    private String email;
    private String zipcode;
    private String address1;
    private String address2;
    private String role;  // 역할 추가

    // Getters / Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getZipcode() { return zipcode; }
    public void setZipcode(String zipcode) { this.zipcode = zipcode; }

    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }

    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
}
