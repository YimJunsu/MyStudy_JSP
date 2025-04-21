<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="dto.Member" %>
<%
    String userSessionId = (String) session.getAttribute("sessionId");
%>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>Welcome!</title>
</head>
<body>
  <div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">책속의 방에 오신 것을 환영합니다!</h1>
        <p class="col-md-8 fs-4">BookMarket</p>
      </div>
    </div>

    <div class="row align-items-md-stretch text-center">
      <div class="col-md-12">
        <div class="h-100 p-5">
          <h3>Welcome to Web Market!</h3>
          <div id="clock" class="mt-3 fw-semibold fs-5 text-primary"></div>

          <c:choose>
            <c:when test="${empty sessionScope.sessionId}">
              <p class="mt-3 text-muted">로그인하지 않으셨습니다. 로그인 후 다양한 기능을 이용할 수 있어요 😊</p>
            </c:when>
            <c:otherwise>
              <p class="mt-3"><strong>${sessionScope.sessionId}님, 환영합니다!</strong></p>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

    <%@ include file="footer.jsp" %>
  </div>
  <script src="${pageContext.request.contextPath}/resources/js/clock.js"></script>
</body>
</html>