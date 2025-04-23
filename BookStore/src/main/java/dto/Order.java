package dto;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private String memberId;
    private Timestamp orderDate;
    private int totalPrice;
    private String status;
    
    public Order() {}
    
    public Order(String memberId, int totalPrice) {
        this.memberId = memberId;
        this.totalPrice = totalPrice;
        this.status = "주문완료";
    }
    
    // Getters & Setters
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public String getMemberId() {
        return memberId;
    }
    
    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }
    
    public Timestamp getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    
    public int getTotalPrice() {
        return totalPrice;
    }
    
    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}