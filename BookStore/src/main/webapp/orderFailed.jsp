<%@ page contentType="text/html; charset=utf-8"%>
<%
    String reason = request.getParameter("reason");
    String errorMessage = "주문 처리 중 오류가 발생했습니다.";
    
    if ("stock".equals(reason)) {
        errorMessage = "주문하신 상품의 재고가 부족합니다.";
    } else if ("db".equals(reason)) {
        errorMessage = "데이터베이스 오류가 발생했습니다.";
    } else if ("payment".equals(reason)) {
        errorMessage = "결제 처리 중 오류가 발생했습니다.";
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>주문 실패</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-5 mb-4 bg-light rounded-3 text-center">
        <h1 class="display-5 fw-bold">⚠️ 주문 실패</h1>
        <p class="fs-4"><%= errorMessage %></p>
    </div>
    
    <div class="text-center mt-4 mb-5">
        <a href="cart.jsp" class="btn btn-primary btn-lg">장바구니로 돌아가기</a>
        <a href="books.jsp" class="btn btn-secondary btn-lg">도서 목록으로</a>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>