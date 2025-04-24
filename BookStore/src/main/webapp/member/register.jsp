<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link href="${pageContext.request.contextPath}/resources/css/register.css" rel="stylesheet" type="text/css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="page-wrapper d-flex flex-column min-vh-100">
    <%@ include file="/menu.jsp" %>

    <main class="flex-grow-1 d-flex justify-content-center align-items-center py-5">
      <div class="container">
        <div class="register-container mx-auto">
          <h2 class="text-center mb-4">지식의 방에 가입하기</h2>
          <form action="registerProcess.jsp" method="post">
            <div class="form-group">
              <input type="text" name="id" placeholder="아이디" required>
            </div>
            <div class="form-group">
              <input type="password" name="password" placeholder="비밀번호" required>
            </div>
            <div class="form-group">
              <input type="text" name="name" placeholder="이름" required>
            </div>
            <div class="form-group">
              <input type="email" name="email" placeholder="이메일" required>
            </div>
            <div class="form-group" style="display: flex; gap: 8px;">
              <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly>
              <button type="button" class="btn-small" onclick="execDaumPostcode()">검색</button>
            </div>
            <div class="form-group">
              <input type="text" id="address1" name="address1" placeholder="기본 주소" readonly>
            </div>
            <div class="form-group">
              <input type="text" id="address2" name="address2" placeholder="상세 주소">
            </div>
            <button type="submit">가입하기</button>
          </form>
        </div>
      </div>
    </main>

    <%@ include file="/footer.jsp" %>
  </div>

  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById("zipcode").value = data.zonecode;
          document.getElementById("address1").value = data.roadAddress;
          document.getElementById("address2").focus();
        }
      }).open();
    }
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
