<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 장바구니 가져오기
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    
    // 모든 요청 파라미터 가져오기
    java.util.Enumeration<String> paramNames = request.getParameterNames();
    
    while (paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        
        // 수량 파라미터인지 확인 (quantity_로 시작)
        if (paramName.startsWith("quantity_")) {
            String bookId = paramName.substring(9); // quantity_ 다음부터가 bookId
            int quantity = Integer.parseInt(request.getParameter(paramName));
            
            // 장바구니 항목 업데이트
            for (Book book : cartList) {
                if (book.getBookId().equals(bookId)) {
                    book.setQuantity(quantity);
                    break;
                }
            }
        }
    }
    
    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>