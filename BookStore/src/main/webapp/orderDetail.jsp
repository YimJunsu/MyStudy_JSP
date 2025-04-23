<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    // 로그인 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String orderIdParam = request.getParameter("id");
    if (orderIdParam == null || orderIdParam.trim().equals("")) {
        response.sendRedirect("myOrders.jsp");
        return;
    }
    
    int orderId = Integer.parseInt(orderIdParam);
    
    OrderRepository orderRepo = new OrderRepository();
    BookRepository bookRepo = new BookRepository();
    
    // 주문 정보 조회
    Order order = orderRepo.getOrderById(orderId);
    
    if (order == null || !order.getMemberId().equals(userId)) {
        response.sendRedirect("myOrders.jsp");
        return;
    }
    
    // 주문 상품 조회
    ArrayList<OrderItem> orderItems = orderRepo.getOrderItemsByOrderId(orderId);
    
    // 배송 정보 조회
    ShippingInfo shippingInfo = orderRepo.getShippingInfoByOrderId(orderId);
    
    // 날짜 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>주문 상세 정보</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="display-6 fw-bold">주문 상세 정보</h1>
                <p class="fs-5 mb-0">주문 번호: <span class="text-primary fw-bold"><%= order.getOrderId() %></span></p>
            </div>
            <a href="/BookStore/member/myOrder.jsp" class="btn btn-outline-primary">목록으로 돌아가기</a>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-10 mx-auto">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">주문 정보</h4>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th class="bg-light" width="30%">주문 번호</th>
                            <td><%= order.getOrderId() %></td>
                        </tr>
                        <tr>
                            <th class="bg-light">주문 일시</th>
                            <td><%= sdf.format(order.getOrderDate()) %></td>
                        </tr>
                        <tr>
                            <th class="bg-light">주문 상태</th>
                            <td>
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
                        </tr>
                        <tr>
                            <th class="bg-light">총 결제 금액</th>
                            <td class="fw-bold"><%= order.getTotalPrice() %> 원</td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">주문 상품</h4>
                </div>
                <div class="card-body">
                    <table class="table table-bordered align-middle">
                        <thead class="table-light text-center">
                            <tr>
                                <th>상품 정보</th>
                                <th>가격</th>
                                <th>수량</th>
                                <th>소계</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                        for (OrderItem item : orderItems) {
                            Book book = bookRepo.getBookById(item.getBookId());
                            int total = item.getPrice() * item.getQuantity();
                        %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="resources/images/<%= book.getFilename() %>" width="60" height="80">
                                        <div>
                                            <div><strong><%= book.getName() %></strong></div>
                                            <div class="text-muted small"><%= book.getBookId() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-center"><%= item.getPrice() %> 원</td>
                                <td class="text-center"><%= item.getQuantity() %></td>
                                <td class="text-center"><%= total %> 원</td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">배송 정보</h4>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th class="bg-light" width="30%">수령인</th>
                            <td><%= shippingInfo.getReceiverName() %></td>
                        </tr>
                        <tr>
                            <th class="bg-light">주소</th>
                            <td>
                                [<%= shippingInfo.getZipcode() %>]<br>
                                <%= shippingInfo.getAddress1() %> <%= shippingInfo.getAddress2() %>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light">연락처</th>
                            <td><%= shippingInfo.getPhone() %></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>