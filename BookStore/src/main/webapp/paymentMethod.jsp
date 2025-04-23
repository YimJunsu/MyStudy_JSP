<%@ page contentType="text/html; charset=utf-8"%>
<%
    int totalAmount = (Integer) session.getAttribute("totalAmount");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>결제 방법 선택</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">💳 결제 방법 선택</h1>
        <p class="fs-5">결제하실 방법을 선택해주세요.</p>
    </div>
    
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">결제 정보</h4>
                </div>
                <div class="card-body">
                    <div class="mb-4 text-center">
                        <h5>총 결제 금액: <span class="text-primary fw-bold"><%= totalAmount %> 원</span></h5>
                    </div>
                    
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">신용/체크카드</h5>
                                    <p class="card-text">신용카드 또는 체크카드로 결제합니다.</p>
                                    <a href="paymentSimulation.jsp?amount=<%= totalAmount %>" class="btn btn-outline-primary">카드 결제</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">무통장 입금</h5>
                                    <p class="card-text">가상계좌 발급 후 입금으로 결제합니다.</p>
                                    <a href="bankTransfer.jsp" class="btn btn-outline-primary">계좌이체</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">포인트 결제</h5>
                                    <p class="card-text">적립된 포인트로 바로 결제합니다.</p>
                                    <a href="pointPayment.jsp" class="btn btn-outline-primary">포인트 결제</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mb-4">
                <a href="orderConfirmation.jsp" class="btn btn-secondary">이전 단계로</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>