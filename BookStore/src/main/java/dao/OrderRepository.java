package dao;

import dto.Order;
import dto.OrderItem;
import dto.ShippingInfo;
import filter.DBConnection;

import java.sql.*;
import java.util.ArrayList;

public class OrderRepository {

    // 싱글톤 인스턴스
    private static OrderRepository instance = new OrderRepository();

    // 외부에서 인스턴스 가져오기
    public static OrderRepository getInstance() {
        return instance;
    }

    // 생성자
    private OrderRepository() {}

    // 주문 생성 및 주문 ID 반환
    public int createOrder(Order order) {
        int orderId = 0;
        String sql = "INSERT INTO orders (member_id, total_price, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, order.getMemberId());
            pstmt.setInt(2, order.getTotalPrice());
            pstmt.setString(3, order.getStatus());
            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    // 주문 항목 추가
    public void addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setString(2, orderItem.getBookId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setInt(4, orderItem.getPrice());
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 배송 정보 추가
    public void addShippingInfo(ShippingInfo shippingInfo) {
        String sql = "INSERT INTO shipping_info (order_id, receiver_name, zipcode, address1, address2, phone) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, shippingInfo.getOrderId());
            pstmt.setString(2, shippingInfo.getReceiverName());
            pstmt.setString(3, shippingInfo.getZipcode());
            pstmt.setString(4, shippingInfo.getAddress1());
            pstmt.setString(5, shippingInfo.getAddress2());
            pstmt.setString(6, shippingInfo.getPhone());
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 주문 상태 업데이트
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 주문 상세 조회
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setMemberId(rs.getString("member_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setStatus(rs.getString("status"));
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    // 주문에 포함된 상품 목록 조회
    public ArrayList<OrderItem> getOrderItemsByOrderId(int orderId) {
        ArrayList<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setBookId(rs.getString("book_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getInt("price"));
                items.add(item);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }

    // 배송 정보 조회
    public ShippingInfo getShippingInfoByOrderId(int orderId) {
        ShippingInfo info = null;
        String sql = "SELECT * FROM shipping_info WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                info = new ShippingInfo();
                info.setShippingId(rs.getInt("shipping_id"));
                info.setOrderId(rs.getInt("order_id"));
                info.setReceiverName(rs.getString("receiver_name"));
                info.setZipcode(rs.getString("zipcode"));
                info.setAddress1(rs.getString("address1"));
                info.setAddress2(rs.getString("address2"));
                info.setPhone(rs.getString("phone"));
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return info;
    }

    // 특정 회원의 전체 주문 조회
    public ArrayList<Order> getOrdersByMemberId(String memberId) {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE member_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setMemberId(rs.getString("member_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // 책 재고 감소
    public boolean decreaseBookStock(String bookId, int quantity) {
        boolean success = false;
        String checkSql = "SELECT units_in_stock FROM book WHERE book_id = ?";
        String updateSql = "UPDATE book SET units_in_stock = units_in_stock - ? WHERE book_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setString(1, bookId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int currentStock = rs.getInt("units_in_stock");
                if (currentStock >= quantity) {
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, quantity);
                        updateStmt.setString(2, bookId);
                        int result = updateStmt.executeUpdate();
                        if (result > 0) {
                            success = true;
                        }
                    }
                }
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // 모든 주문 목록 조회
    public ArrayList<Order> getAllOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setMemberId(rs.getString("member_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
