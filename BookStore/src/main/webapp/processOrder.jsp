<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String imp_uid = request.getParameter("imp_uid");
    String merchant_uid = request.getParameter("merchant_uid");
    
    // 장바구니 및 배송 정보 확인
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    String receiverName = (String) session.getAttribute("receiverName");
    String zipcode = (String) session.getAttribute("zipcode");
    String address1 = (String) session.getAttribute("address1");
    String address2 = (String) session.getAttribute("address2");
    String phone = (String) session.getAttribute("phone");
    Integer totalAmount = (Integer) session.getAttribute("totalAmount");
    
    if (userId == null || cartList == null || receiverName == null || 
        zipcode == null || address1 == null || phone == null || totalAmount == null) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    // 주문 생성
    OrderRepository orderRepo = new OrderRepository();
    BookRepository bookRepo = new BookRepository();
    
    // 1. orders 테이블에 주문 기록 생성
    Order order = new Order(userId, totalAmount);
    int orderId = orderRepo.createOrder(order);
    
    if (orderId > 0) {
        // 2. order_items 테이블에 주문 상품 추가
        boolean stockCheckFailed = false;
        
        for (Book book : cartList) {
            // 재고 확인 및 감소
            boolean stockUpdated = orderRepo.decreaseBookStock(book.getBookId(), book.getQuantity());
            
            if (!stockUpdated) {
                stockCheckFailed = true;
                break;
            }
            
            // 주문 상품 추가
            OrderItem orderItem = new OrderItem(
                orderId, 
                book.getBookId(), 
                book.getQuantity(), 
                book.getUnitPrice()
            );
            orderRepo.addOrderItem(orderItem);
        }
        
        // 재고 확인 실패 시
        if (stockCheckFailed) {
            // 주문 상태를 '재고 부족'으로 변경
            orderRepo.updateOrderStatus(orderId, "재고 부족");
            response.sendRedirect("orderFailed.jsp?reason=stock");
            return;
        }
        
        // 3. shipping_info 테이블에 배송 정보 추가
        ShippingInfo shippingInfo = new ShippingInfo(
            orderId,
            receiverName,
            zipcode,
            address1,
            address2,
            phone
        );
        orderRepo.addShippingInfo(shippingInfo);
        
        // 4. 주문 완료 후 장바구니 비우기
        session.removeAttribute("cartlist");
        
        // 5. 세션에서 배송 정보 제거
        session.removeAttribute("receiverName");
        session.removeAttribute("zipcode");
        session.removeAttribute("address1");
        session.removeAttribute("address2");
        session.removeAttribute("phone");
        session.removeAttribute("totalAmount");
        
        // 주문 완료 페이지로 이동
        response.sendRedirect("orderCompleted.jsp?id=" + orderId);
    } else {
        // 주문 생성 실패 시
        response.sendRedirect("orderFailed.jsp?reason=db");
    }
%>