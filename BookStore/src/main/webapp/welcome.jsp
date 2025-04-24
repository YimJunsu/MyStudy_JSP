<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="dto.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String userSessionId = (String) session.getAttribute("sessionId");
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>지식의 방</title>
  <link href="${pageContext.request.contextPath}/resources/css/welcome.css" rel="stylesheet" type="text/css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <%@ include file="menu.jsp" %>

    <div class="main-hero text-center">
      <h1 class="fw-bold">지식의 방에 오신 것을 환영합니다!</h1>
      <p class="fs-4 text-muted">당신만의 책을 찾아보세요 📚</p>
	  <br/>
      <h3 class="mb-4">Welcome to Book Store!</h3>
      <div id="clock" class="fw-semibold fs-5 mb-3"></div>
	  <br/>
      <c:choose>
	    <c:when test="${empty sessionScope.userId}">
	        <p class="text-muted">로그인하지 않으셨습니다. 로그인 후 다양한 기능을 이용할 수 있어요 😊</p>
	    </c:when>
	    <c:otherwise>
	        <p><strong>${sessionScope.userId}님, 환영합니다!</strong></p>
	    </c:otherwise>
	</c:choose>
    </div>
   
	<!-- 베스트셀러 섹션 -->
	<div class="mt-5">
	  <h3 class="mb-4 text-center fw-bold">🔥따끈 따근 신작🔥</h3>
	  <div class="row row-cols-1 row-cols-md-3 g-4 text-center">
	    <%@ include file="dbconn.jsp" %>
	    <%
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      try {
	          // 현재는 최신 등록 기준으로 3개만 가져오기
	          String sql = "SELECT * FROM book ORDER BY book_id DESC LIMIT 3";
	          ps = conn.prepareStatement(sql);
	          rs = ps.executeQuery();
	          while (rs.next()) {
	              String desc = rs.getString("description");
	              if (desc != null && desc.length() > 60) {
	                  desc = desc.substring(0, 60) + "...";
	              }
	    %>
	    <div class="col">
	      <div class="card h-100 shadow-sm">
	        <img src="resources/images/<%=rs.getString("filename") != null ? rs.getString("filename") : "default.jpg"%>" 
	             class="card-img-top" style="height:350px; object-fit:cover;" alt="도서 이미지">
	        <div class="card-body">
	          <h5 class="card-title"><%=rs.getString("name")%></h5>
	          <p class="card-text text-muted"><%=rs.getString("author")%> / <%=rs.getString("publisher")%></p>
	          <p class="card-text"><%=desc%></p>
	          <a href="book.jsp?id=<%=rs.getString("book_id")%>" class="btn btn-outline-primary mt-2">상세 보기</a>
	        </div>
	      </div>
	    </div>
	    <%
	          }
	      } catch (SQLException e) {
	          out.println("❌ 오류 발생: " + e.getMessage());
	      } finally {
	          if (rs != null) try { rs.close(); } catch (SQLException e) { }
	          if (ps != null) try { ps.close(); } catch (SQLException e) { }
	          if (conn != null) try { conn.close(); } catch (SQLException e) { }
	      }
	    %>
	  </div>
	</div>
    
    <%@ include file="footer.jsp" %>
  </div>

  <script src="${pageContext.request.contextPath}/resources/js/clock.js"></script>
</body>
</html>
