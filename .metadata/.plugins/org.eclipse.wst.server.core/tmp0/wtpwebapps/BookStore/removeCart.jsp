<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%
    String id = request.getParameter("id");
    
    // 장바구니 가져오기
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    
    // 해당 상품 제거
    if (cartList != null && id != null) {
        for (int i = 0; i < cartList.size(); i++) {
            Book book = cartList.get(i);
            if (book.getBookId().equals(id)) {
                cartList.remove(i);
                break;
            }
        }
    }
    
    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>