<%@page import="dto.Book"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
    String cartId = session.getId();
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    if (cartList == null || cartList.size() == 0) {
        cartList = new ArrayList<Book>();
        session.setAttribute("cartlist", cartList);
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>장바구니</title>
</head>
<body>
<div class="container py-4">
    <%@include file="menu.jsp" %>

    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">🛒 장바구니</h1>
        <p class="fs-5">* 로그아웃 시 장바구니가 초기화될 수 있습니다.</p>
    </div>

    <% if (cartList.isEmpty()) { %>
        <div class="alert alert-warning text-center" role="alert">
            장바구니가 비어 있습니다. <br>
            <a href="books.jsp" class="btn btn-primary mt-3">도서 보러가기</a>
        </div>
    <% } else { 
        int sum = 0;
    %>
        <!-- 수량 수정 폼 시작 -->
		<form action="updateCart.jsp" method="post">
		<table class="table table-bordered align-middle text-center">
		    <thead class="table-light">
		        <tr>
		            <th>도서 정보</th>
		            <th>가격</th>
		            <th>수량</th>
		            <th>소계</th>
		            <th>비고</th>
		        </tr>
		    </thead>
		    <tbody>
		        <% for (Book book : cartList) {
		            int total = book.getUnitPrice() * book.getQuantity();
		            sum += total;
		        %>
		        <tr>
		            <td>
		                <div class="d-flex align-items-center gap-3">
		                    <img src="resources/images/<%=book.getFilename()%>" width="80" height="100">
		                    <div class="text-start">
		                        <div><strong><%=book.getName()%></strong></div>
		                        <div class="text-muted">(<%=book.getBookId()%>)</div>
		                    </div>
		                </div>
		            </td>
		            <td><%=book.getUnitPrice()%> 원</td>
		            <td>
		                <input type="number" name="quantity_<%=book.getBookId()%>" value="<%=book.getQuantity()%>" min="1" class="form-control" style="width:80px; margin:auto;">
		            </td>
		            <td><%=total%> 원</td>
		            <td>
		                <a href="./removeCart.jsp?id=<%=book.getBookId()%>" class="btn btn-sm btn-outline-danger">삭제</a>
		            </td>
		        </tr>
		        <% } %>
		        <tr class="table-secondary">
		            <td colspan="3" class="text-end fw-bold">총액</td>
		            <td colspan="2" class="fw-bold"><%=sum%> 원</td>
		        </tr>
		    </tbody>
		</table>
		<!-- 수량 수정 버튼 추가 -->
		<div class="text-end mb-4">
		    <input type="submit" value="수량 수정하기" class="btn btn-primary">
		</div>
		</form>
        <div class="d-flex justify-content-between mt-4">
            <a href="./deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-outline-danger">장바구니 전체 비우기</a>
            <div>
                <a href="./books.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
                <a href="./shippingInfo.jsp?cartId=<%=cartId%>" class="btn btn-success">주문하기 &raquo;</a>
            </div>
        </div>
    <% } %>

    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>
