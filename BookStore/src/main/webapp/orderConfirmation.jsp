<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%@ page import="dto.Member"%>
<%@ page import="dao.MemberRepository"%>
<%
    String cartId = session.getId();
    
    // 로그인 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp?redirect=orderConfirmation.jsp");
        return;
    }
    
    // 장바구니 확인
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    if (cartList == null || cartList.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    // 배송 정보 확인
    String receiverName = (String) session.getAttribute("receiverName");
    String zipcode = (String) session.getAttribute("zipcode");
    String address1 = (String) session.getAttribute("address1");
    String address2 = (String) session.getAttribute("address2");
    String phone = (String) session.getAttribute("phone");
    
    if (receiverName == null || zipcode == null || address1 == null || phone == null) {
        response.sendRedirect("shippingInfo.jsp");
        return;
    }
    
    // 회원 정보 가져오기
    MemberRepository memberRepo = new MemberRepository();
    Member member = memberRepo.findById(userId);
    
    // 총 금액 계산
    int totalAmount = (Integer) session.getAttribute("totalAmount");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    function cancelOrder() {
        if (confirm("주문을 취소하시겠습니까?")) {
            location.href = "cart.jsp";
        }
    }
    
    function requestPay() {
        const IMP = window.IMP;
        IMP.init("imp18501418"); // 테스트 모드 가맹점 식별코드 (실제 발급받은 테스트 코드로 변경 필요)
        
        IMP.request_pay({
            pg: "nice", // 테스트 모드 제공 PG사 중 하나 
            pay_method: "card",
            merchant_uid: "ORD_" + new Date().getTime(),
            name: "책 주문 (<%= cartList.size() %>종)",
            amount: 100, // 테스트 모드에서는 실제 금액 대신 100원으로 설정
            // 실제 서비스 시: amount: <%= totalAmount %>,
            buyer_email: "<%= member.getEmail() %>",
            buyer_name: "<%= member.getName() %>",
            buyer_tel: "<%= phone %>",
            buyer_addr: "<%= address1 %> <%= address2 %>",
            buyer_postcode: "<%= zipcode %>",
            // 테스트 모드 활성화
            custom_data: {
                test_mode: true
            }
        }, function(rsp) {
            if (rsp.success) {
                // 결제 성공 시
                document.getElementById("imp_uid").value = rsp.imp_uid;
                document.getElementById("merchant_uid").value = rsp.merchant_uid;
                document.getElementById("paymentForm").submit();
            } else {
                // 결제 실패 시
                alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
            }
        });
    }
</script>
<title>주문 확인</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="/menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">🔍 주문 확인</h1>
        <p class="fs-5">* 주문 내역을 확인하고 결제를 진행해주세요.</p>
    </div>
    
    <div class="alert alert-info">
        <strong>안내:</strong> 포트폴리오 시연용으로 테스트 결제가 진행됩니다. 실제 결제는 이루어지지 않으니 안심하고 테스트하세요.
    </div>
    
    <div class="row">
        <div class="col-md-10 mx-auto">
            <h3 class="mb-3">📚 주문 상품</h3>
            <table class="table table-bordered align-middle">
                <thead class="table-light text-center">
                    <tr>
                        <th>도서</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>소계</th>
                    </tr>
                </thead>
                <tbody>
                <% 
                for (Book book : cartList) {
                    int total = book.getUnitPrice() * book.getQuantity();
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
                        <td class="text-center"><%= book.getUnitPrice() %> 원</td>
                        <td class="text-center"><%= book.getQuantity() %></td>
                        <td class="text-center"><%= total %> 원</td>
                    </tr>
                <% } %>
                    <tr class="table-warning">
                        <td colspan="3" class="text-end fw-bold">총액</td>
                        <td class="text-center fw-bold"><%= totalAmount %> 원</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="row mt-5">
                <div class="col-md-6">
                    <h3 class="mb-3">👤 주문자 정보</h3>
                    <table class="table table-bordered">
                        <tr>
                            <th class="bg-light" width="30%">이름</th>
                            <td><%= member.getName() %></td>
                        </tr>
                        <tr>
                            <th class="bg-light">이메일</th>
                            <td><%= member.getEmail() %></td>
                        </tr>
                    </table>
                </div>
                
                <div class="col-md-6">
                    <h3 class="mb-3">📦 배송 정보</h3>
                    <table class="table table-bordered">
                        <tr>
                            <th class="bg-light" width="30%">수령인</th>
                            <td><%= receiverName %></td>
                        </tr>
                        <tr>
                            <th class="bg-light">주소</th>
                            <td>
                                [<%= zipcode %>]<br>
                                <%= address1 %> <%= address2 %>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light">연락처</th>
                            <td><%= phone %></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div class="d-flex justify-content-between mt-4">
                <button type="button" class="btn btn-secondary" onclick="cancelOrder()">주문 취소</button>
                <button type="button" class="btn btn-primary" onclick="requestPay()">테스트 결제하기</button>
            </div>
            
            <!-- 결제 성공 시 전송될 폼 -->
            <form id="paymentForm" action="processOrder.jsp" method="post">
                <input type="hidden" id="imp_uid" name="imp_uid">
                <input type="hidden" id="merchant_uid" name="merchant_uid">
            </form>
        </div>
    </div>
    
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>