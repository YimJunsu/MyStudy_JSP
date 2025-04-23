package dto;

public class ShippingInfo {
    private int shippingId;
    private int orderId;
    private String receiverName;
    private String zipcode;
    private String address1;
    private String address2;
    private String phone;
    
    public ShippingInfo() {}
    
    public ShippingInfo(int orderId, String receiverName, String zipcode, 
                        String address1, String address2, String phone) {
        this.orderId = orderId;
        this.receiverName = receiverName;
        this.zipcode = zipcode;
        this.address1 = address1;
        this.address2 = address2;
        this.phone = phone;
    }
    
    // Getters & Setters
    public int getShippingId() {
        return shippingId;
    }
    
    public void setShippingId(int shippingId) {
        this.shippingId = shippingId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public String getReceiverName() {
        return receiverName;
    }
    
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }
    
    public String getZipcode() {
        return zipcode;
    }
    
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }
    
    public String getAddress1() {
        return address1;
    }
    
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    
    public String getAddress2() {
        return address2;
    }
    
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
}