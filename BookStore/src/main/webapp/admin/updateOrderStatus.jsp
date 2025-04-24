<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dao.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 로그인된 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // 관리자 권한 체크: userId가 없거나 role이 admin이 아니면 로그인 페이지로 리다이렉트
    if (userId == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("exceptionNoPage.jsp");
        return;
    }
    String orderIdParam = request.getParameter("orderId");
    String status = request.getParameter("status");
    
    if (orderIdParam != null && status != null) {
        try {
            int orderId = Integer.parseInt(orderIdParam);
            // 주문 상태 업데이트
            OrderRepository orderRepo = OrderRepository.getInstance();
            orderRepo.updateOrderStatus(orderId, status);
        } catch (NumberFormatException e) {
            // 주문 ID가 올바르지 않으면 예외 처리 (로그 기록 등 추가 가능)
            e.printStackTrace();
        }
    }
    
    // 상태 업데이트 후, 주문 관리 페이지로 리다이렉트
    response.sendRedirect("orderManagement.jsp");
%>
