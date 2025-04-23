<%@ page contentType="text/html; charset=utf-8"%>
<%
    String totalAmount = request.getParameter("amount");
    if (totalAmount == null) {
        totalAmount = "0";
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>결제 시뮬레이션</title>
<script>
    function validatePayment() {
        var cardNumber = document.getElementById("cardNumber").value;
        var expiryDate = document.getElementById("expiryDate").value;
        var cvv = document.getElementById("cvv").value;
        
        // 간단한 유효성 검사
        if (cardNumber.length < 16) {
            alert("올바른 카드번호를 입력하세요.");
            return false;
        }
        if (expiryDate.length < 5) {
            alert("올바른 유효기간을 입력하세요.");
            return false;
        }
        if (cvv.length < 3) {
            alert("올바른 보안코드를 입력하세요.");
            return false;
        }
        
        // 랜덤하게 결제 성공/실패 시뮬레이션 (90% 성공률)
        var randomSuccess = Math.random() < 0.9;
        if (randomSuccess) {
            document.getElementById("payment_status").value = "success";
            return true;
        } else {
            document.getElementById("payment_status").value = "failed";
            document.getElementById("errorMessage").textContent = "결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.";
            document.getElementById("errorAlert").classList.remove("d-none");
            return false;
        }
    }
</script>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">결제 정보 입력</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-info mb-4">
                        <small><i class="bi bi-info-circle"></i> 예시용 결제.</small>
                    </div>
                    
                    <div class="alert alert-danger d-none" id="errorAlert">
                        <span id="errorMessage"></span>
                    </div>
                    
                    <form action="processPayment.jsp" method="post" onsubmit="return validatePayment()">
                        <input type="hidden" name="payment_status" id="payment_status" value="pending">
                        
                        <div class="mb-3">
                            <label for="totalAmount" class="form-label">결제 금액</label>
                            <input type="text" class="form-control" id="totalAmount" value="<%= totalAmount %> 원" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label for="cardNumber" class="form-label">카드 번호</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>
                            <div class="form-text">테스트용 예시: 4111 1111 1111 1111</div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="expiryDate" class="form-label">유효 기간</label>
                                <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                            </div>
                            <div class="col-md-6">
                                <label for="cvv" class="form-label">보안 코드</label>
                                <input type="text" class="form-control" id="cvv" name="cvv" placeholder="123" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="cardHolder" class="form-label">카드 소유자 이름</label>
                            <input type="text" class="form-control" id="cardHolder" name="cardHolder" placeholder="HONG GILDONG" required>
                        </div>
                        
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg">결제하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>