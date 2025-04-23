<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    String orderId = request.getParameter("id");
    
    if (orderId == null || orderId.trim().equals("")) {
        response.sendRedirect("books.jsp");
        return;
    }
    
    OrderRepository orderRepo = new OrderRepository();
    BookRepository bookRepo = new BookRepository();
    
    // 주문 정보 조회
    Order order = orderRepo.getOrderById(Integer.parseInt(orderId));
    
    if (order == null) {
        response.sendRedirect("books.jsp");
        return;
    }
    
    // 주문 상품 조회
    ArrayList<OrderItem> orderItems = orderRepo.getOrderItemsByOrderId(order.getOrderId());
    
    // 배송 정보 조회
    ShippingInfo shippingInfo = orderRepo.getShippingInfoByOrderId(order.getOrderId());
    
    // 날짜 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>주문 완료</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="/menu.jsp" %>
    
    <div class="p-5 mb-4 bg-light rounded-3 text-center">
        <h1 class="display-5 fw-bold">🎉 주문 완료</h1>
        <p class="fs-4">주문이 성공적으로 완료되었습니다.</p>
        <p class="fs-5">주문 번호: <span class="text-primary fw-bold"><%= order.getOrderId() %></span></p>
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
                            <td><span class="badge bg-success"><%= order.getStatus() %></span></td>
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
            
            <div class="text-center mt-4 mb-5">
                <a href="books.jsp" class="btn btn-primary btn-lg">쇼핑 계속하기</a>
                <a href="/BookStore/member/myOrder.jsp" class="btn btn-success btn-lg">내 주문 내역</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>