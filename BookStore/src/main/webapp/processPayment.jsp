<%@ page contentType="text/html; charset=utf-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String paymentStatus = request.getParameter("payment_status");
    
    if ("success".equals(paymentStatus)) {
        // 결제 성공 시 주문 처리 페이지로 이동
        response.sendRedirect("processOrder.jsp");
    } else {
        // 결제 실패 시 에러 페이지로 이동
        response.sendRedirect("orderFailed.jsp?reason=payment");
    }
%>