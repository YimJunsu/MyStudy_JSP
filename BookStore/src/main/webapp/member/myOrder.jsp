<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    // 로그인 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp?redirect=myOrders.jsp");
        return;
    }
    
    OrderRepository orderRepo = OrderRepository.getInstance();
    ArrayList<Order> orderList = orderRepo.getOrdersByMemberId(userId);
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>내 주문 내역</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="/menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">📋 내 주문 내역</h1>
        <p class="fs-5">* 주문하신 내역을 확인할 수 있습니다.</p>
    </div>
    
    <% if (orderList.isEmpty()) { %>
    <div class="alert alert-warning text-center" role="alert">
        주문 내역이 없습니다. <br>
        <a href="/BookStore/books.jsp" class="btn btn-primary mt-3">도서 보러가기</a>
    </div>
    <% } else { %>
    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-light text-center">
                <tr>
                    <th>주문 번호</th>
                    <th>주문 일시</th>
                    <th>결제 금액</th>
                    <th>주문 상태</th>
                    <th>상세 보기</th>
                </tr>
            </thead>
            <tbody>
            <% for (Order order : orderList) { %>
                <tr>
                    <td class="text-center"><%= order.getOrderId() %></td>
                    <td class="text-center"><%= sdf.format(order.getOrderDate()) %></td>
                    <td class="text-end"><%= order.getTotalPrice() %> 원</td>
                    <td class="text-center">
                        <% if ("주문완료".equals(order.getStatus())) { %>
                            <span class="badge bg-success"><%= order.getStatus() %></span>
                        <% } else if ("배송중".equals(order.getStatus())) { %>
                            <span class="badge bg-primary"><%= order.getStatus() %></span>
                        <% } else if ("배송완료".equals(order.getStatus())) { %>
                            <span class="badge bg-secondary"><%= order.getStatus() %></span>
                        <% } else if ("재고 부족".equals(order.getStatus())) { %>
                            <span class="badge bg-danger"><%= order.getStatus() %></span>
                        <% } else { %>
                            <span class="badge bg-info"><%= order.getStatus() %></span>
                        <% } %>
                    </td>
                    <td class="text-center">
                        <a href="/BookStore/orderDetail.jsp?id=<%= order.getOrderId() %>" class="btn btn-sm btn-outline-primary">상세 보기</a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
    
    <div class="text-center mt-4">
        <a href="/BookStore/books.jsp" class="btn btn-primary">도서 쇼핑하기</a>
    </div>
    
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>