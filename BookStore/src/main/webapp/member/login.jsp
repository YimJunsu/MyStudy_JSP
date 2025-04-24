<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="page-wrapper d-flex flex-column min-vh-100">
    <%@ include file="/menu.jsp" %>

    <main class="flex-grow-1 d-flex justify-content-center align-items-center py-5">
      <div class="container">
        <div class="login-container mx-auto">
          <h2 class="text-center mb-4">로그인</h2>
          <form action="loginProcess.jsp" method="post">
            <input type="text" name="id" placeholder="아이디" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
          </form>
          <div class="signup-link text-center mt-3">
            아직 회원이 아니신가요? <a href="register.jsp">회원가입</a>
          </div>
        </div>
      </div>
    </main>

    <%@ include file="/footer.jsp" %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
