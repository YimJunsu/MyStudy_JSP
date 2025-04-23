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
        response.sendRedirect("member/login.jsp");
        return;
    }
    
    // 장바구니 확인
    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
    if (cartList == null || cartList.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    // 회원 정보 가져오기
	MemberRepository memberRepo = new MemberRepository();
	Member member = memberRepo.findById(userId);

%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById('address1').value = data.roadAddress;
                document.getElementById('address2').focus();
            }
        }).open();
    }
    
    function validateForm() {
        if (!document.shipping.receiverName.value) {
            alert("수령인 이름을 입력하세요.");
            return false;
        }
        if (!document.shipping.zipcode.value) {
            alert("우편번호를 입력하세요.");
            return false;
        }
        if (!document.shipping.address1.value) {
            alert("주소를 입력하세요.");
            return false;
        }
        if (!document.shipping.phone.value) {
            alert("연락처를 입력하세요.");
            return false;
        }
        return true;
    }
</script>
<title>배송 정보</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-4 mb-4 bg-body-tertiary rounded-3 text-center">
        <h1 class="display-5 fw-bold">📦 배송 정보</h1>
        <p class="fs-5">* 배송지 정보를 입력해주세요.</p>
    </div>
    
    <div class="row">
        <div class="col-md-8 mx-auto">
            <form name="shipping" action="processShippingInfo.jsp" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="cartId" value="<%= cartId %>" />
                
                <div class="mb-3 row">
                    <label for="receiverName" class="col-sm-3 col-form-label">수령인</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="receiverName" name="receiverName" value="<%= member.getName() %>">
                    </div>
                </div>
                
                <div class="mb-3 row">
                    <label for="zipcode" class="col-sm-3 col-form-label">우편번호</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="zipcode" name="zipcode" value="<%= member.getZipcode() != null ? member.getZipcode() : "" %>" readonly>
                    </div>
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-secondary w-100" onclick="execDaumPostcode()">우편번호 찾기</button>
                    </div>
                </div>
                
                <div class="mb-3 row">
                    <label for="address1" class="col-sm-3 col-form-label">주소</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="address1" name="address1" value="<%= member.getAddress1() != null ? member.getAddress1() : "" %>" readonly>
                    </div>
                </div>
                
                <div class="mb-3 row">
                    <label for="address2" class="col-sm-3 col-form-label">상세주소</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="address2" name="address2" value="<%= member.getAddress2() != null ? member.getAddress2() : "" %>">
                    </div>
                </div>
                
                <div class="mb-3 row">
                    <label for="phone" class="col-sm-3 col-form-label">연락처</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="'-' 없이 숫자만 입력하세요">
                        <div class="form-text">주문 및 배송 관련 연락을 위해 사용됩니다.</div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="./cart.jsp" class="btn btn-secondary"> &laquo; 장바구니로 돌아가기</a>
                    <button type="submit" class="btn btn-primary">결제하기 &raquo;</button>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>