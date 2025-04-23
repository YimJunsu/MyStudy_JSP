<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%
    request.setCharacterEncoding("UTF-8");

    String cartId = request.getParameter("cartId");
    String receiverName = request.getParameter("receiverName");
    String zipcode = request.getParameter("zipcode");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String phone = request.getParameter("phone");
    
    // 배송 정보를 세션에 저장
    session.setAttribute("receiverName", receiverName);
    session.setAttribute("zipcode", zipcode);
    session.setAttribute("address1", address1);
    session.setAttribute("address2", address2);
    session.setAttribute("phone", phone);
    
    // 장바구니 확인
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    if (cartList == null || cartList.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    // 총 금액 계산
    int sum = 0;
    for (Book book : cartList) {
        sum += book.getUnitPrice() * book.getQuantity();
    }
    
    session.setAttribute("totalAmount", sum);
    
    // 결제 페이지로 이동
    response.sendRedirect("orderConfirmation.jsp");
%>