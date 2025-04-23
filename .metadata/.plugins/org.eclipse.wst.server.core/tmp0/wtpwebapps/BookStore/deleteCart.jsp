<%@ page contentType="text/html; charset=utf-8"%>
<%
    String cartId = request.getParameter("cartId");
    
    if (cartId != null && cartId.equals(session.getId())) {
        session.removeAttribute("cartlist");
    }
    
    response.sendRedirect("cart.jsp");
%>