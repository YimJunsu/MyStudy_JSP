<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String userId = (String) session.getAttribute("userId");
String role = (String) session.getAttribute("role");

	// 로그인 안 했거나, 권한이 admin이 아니면
	if (userId == null || role == null || !"admin".equals(role)) {
	    response.sendRedirect("exceptionNoPage.jsp");
	    return;
	}
    
    OrderRepository orderRepo = new OrderRepository();
    // 모든 주문 가져오기 (실제로는 페이징 처리 필요)
    List<Order> allOrders = orderRepo.getAllOrders();
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>주문 관리</title>
</head>
<body>
<div class="container py-4">
    <div class="p-4 mb-4 bg-body-tertiary rounded-3">
        <h1 class="display-5 fw-bold">주문 관리</h1>
        <p class="fs-5">* 모든 주문을 관리할 수 있습니다.</p>
    </div>
    
    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark text-center">
                <tr>
                    <th>주문 번호</th>
                    <th>회원 ID</th>
                    <th>주문 일시</th>
                    <th>금액</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
            <% for (Order order : allOrders) { %>
                <tr>
                    <td class="text-center"><%= order.getOrderId() %></td>
                    <td class="text-center"><%= order.getMemberId() %></td>
                    <td class="text-center"><%= sdf.format(order.getOrderDate()) %></td>
                    <td class="text-end"><%= order.getTotalPrice() %> 원</td>
                    <td class="text-center">
                        <form action="updateOrderStatus.jsp" method="post" class="d-flex align-items-center gap-2">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <select name="status" class="form-select form-select-sm">
                                <option value="주문완료" <%= "주문완료".equals(order.getStatus()) ? "selected" : "" %>>주문완료</option>
                                <option value="배송준비중" <%= "배송준비중".equals(order.getStatus()) ? "selected" : "" %>>배송준비중</option>
                                <option value="배송중" <%= "배송중".equals(order.getStatus()) ? "selected" : "" %>>배송중</option>
                                <option value="배송완료" <%= "배송완료".equals(order.getStatus()) ? "selected" : "" %>>배송완료</option>
                                <option value="취소" <%= "취소".equals(order.getStatus()) ? "selected" : "" %>>취소</option>
                                <option value="환불" <%= "환불".equals(order.getStatus()) ? "selected" : "" %>>환불</option>
                            </select>
                            <button type="submit" class="btn btn-sm btn-primary">변경</button>
                        </form>
                    </td>
                    <td class="text-center">
                        <a href="adminOrderDetail.jsp?id=<%= order.getOrderId() %>" class="btn btn-sm btn-info">상세</a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
</html>