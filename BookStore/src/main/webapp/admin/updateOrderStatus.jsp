<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dao.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 관리자 로그인 체크
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    String orderIdParam = request.getParameter("orderId");
    String status = request.getParameter("status");
    
    if (orderIdParam != null && status != null) {
        int orderId = Integer.parseInt(orderIdParam);
        
        OrderRepository orderRepo = new OrderRepository();
        orderRepo.updateOrderStatus(orderId, status);
    }
    
    response.sendRedirect("orderManagement.jsp");
%>