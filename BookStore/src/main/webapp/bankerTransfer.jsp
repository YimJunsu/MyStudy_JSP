<%@ page contentType="text/html; charset=utf-8"%>
<%
    int totalAmount = (Integer) session.getAttribute("totalAmount");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>무통장 입금</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">무통장 입금 안내</h1>
        <p class="fs-5">아래 계좌로 입금해주세요.</p>
    </div>
    
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">입금 정보</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-info">
                        <p>입금이 확인되면 주문이 처리됩니다. 주문 후 24시간 이내에 입금해주세요.</p>
                    </div>
                    
                    <table class="table table-bordered">
                        <tr>
                            <th class="bg-light" width="30%">입금 금액</th>
                            <td class="fw-bold"><%= totalAmount %> 원</td>
                        </tr>
                        <tr>
                            <th class="bg-light">입금 은행</th>
                            <td>신한 은행</td>
                        </tr>
                        <tr>
                            <th class="bg-light">계좌번호</th>
                            <td>110-525-816390</td>
                        </tr>
                        <tr>
                            <th class="bg-light">예금주</th>
                            <td>지식의 방</td>
                        </tr>
                    </table>
                    
                    <form action="processOrder.jsp" method="post" class="mt-4">
                        <input type="hidden" name="payment_method" value="bank_transfer">
                        <div class="mb-3">
                            <label for="depositor" class="form-label">입금자명</label>
                            <input type="text" class="form-control" id="depositor" name="depositor" required>
                        </div>
                        
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success">주문 완료하기</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="text-center mb-4">
                <a href="paymentMethod.jsp" class="btn btn-secondary">다른 결제 방법 선택</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>