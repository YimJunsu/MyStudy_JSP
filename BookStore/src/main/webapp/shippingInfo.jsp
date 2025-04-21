<%@ page contentType="text/html; charset=utf-8" %>
<%
	// 세션정보에서 로그인 확인
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("member/login.jsp");
        return;
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>배송 정보</title>
</head>
<body>
<div class="container py-4">
	<%@include file="menu.jsp" %>
	
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
			<h1 class="display-5 fw-bold">배송 정보</h1>
			<p class="col-md-8 fs-4">Shipping Info</p>
		</div>
	</div>
	
	<div class="row align-items-md-stretch">
		<form action="./processShippingInfo.jsp" method="POST">
			<input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>">
			<div class="mb-3 row"><!-- 성명 -->
				<label class="col-sm-2">성명</label>
				<div>
					<input type="text" name="name" class="form-control">	
				</div>
			</div>
			<div class="mb-3 row"><!-- 배송일 -->
				<label class="col-sm-2">배송일</label>
				<div>
					<input type="text" name="shippingDate" class="form-control">(yyyy/mm/dd)
				</div>
			</div>
			<div class="mb-3 row"><!-- 국가명 -->
				<label class="col-sm-2">국가명</label>
				<div>
					<input type="text" name="country" class="form-control">	
				</div>
			</div>
			<div class="mb-3 row"><!-- 우편번호 -->
				<label class="col-sm-2">우편번호</label>
				<div>
					<input type="text" name="zipCode" class="form-control">	
				</div>
			</div>
			<div class="mb-3 row"><!-- 주소 -->
				<label class="col-sm-2">주소</label>
				<div>
					<input type="text" name="addressName" class="form-control">	
				</div>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-offset-2 col-sm-10">
					<a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a>
					<input type="submit" class="btn btn-primary" value="등록" />
					<a href="./cheakOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
				</div>
			</div>
		</form>	
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>