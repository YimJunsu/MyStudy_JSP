<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String sessionId = (String) session.getAttribute("sessionId");
    System.out.println("Debug: welcome sessionId = " + sessionId); // 콘솔 출력
%>

<!-- Bootstrap 적용 -->
<header class="py-3 mb-4 border-bottom bg-white shadow-sm">
  <div class="container d-flex flex-wrap justify-content-between align-items-center">
    <!-- Home 아이콘 & 타이틀 -->
    <a href="<c:url value='/welcome.jsp'/>" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
      <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-house-fill me-2" viewBox="0 0 16 16">
        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a1 1 0 0 0 .708.708L8 2.207 14.646 8.854a1 1 0 0 0 .708-.708L8.707 1.5Z"/>
        <path d="M8 3.293l6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 1 13.5V9.293l6-6z"/>
      </svg>
      <span class="fs-4 fw-semibold">Online Bookstore</span>
    </a>

    <!-- 네비게이션 -->
    <ul class="nav">
      <li class="nav-item"><a class="nav-link text-dark" href="<c:url value='/books.jsp'/>">도서 목록</a></li>
      <li class="nav-item"><a class="nav-link text-dark" href="<c:url value='/addBook.jsp'/>">도서 등록</a></li>
      <li class="nav-item"><a class="nav-link text-dark" href="<c:url value='/editBook.jsp?edit=update'/>">도서 수정</a></li>
      <li class="nav-item"><a class="nav-link text-dark" href="<c:url value='/editBook.jsp?edit=delete'/>">도서 삭제</a></li>
      <c:choose>
        <c:when test="${empty sessionScope.sessionId}">
          <li class="nav-item"><a class="nav-link text-primary" href="<c:url value='/member/login.jsp'/>">로그인</a></li>
          <li class="nav-item"><a class="nav-link text-primary" href="<c:url value='/member/register.jsp'/>">회원가입</a></li>
        </c:when>
        <c:otherwise>
          <li class="nav-item pt-2 px-2 text-muted">[${sessionScope.sessionId}님]</li>
          <li class="nav-item"><a class="nav-link text-danger" href="/BookStore/member/logout.jsp">로그아웃</a></li>
          <li class="nav-item"><a class="nav-link text-dark" href="<c:url value='/updateMember.jsp'/>">회원 수정</a></li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</header>