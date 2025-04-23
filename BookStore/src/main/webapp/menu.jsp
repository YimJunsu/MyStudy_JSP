<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 여기서 중복된 userId 선언을 삭제하거나 주석 처리하세요.
    // String userId = (String) session.getAttribute("userId"); // 이 줄을 삭제하거나 주석 처리
    String sessionRole = (String) session.getAttribute("role");
    System.out.println("Debug: userId = " + (String) session.getAttribute("userId") + ", role = " + sessionRole);
%>
<header class="py-3 mb-4 border-bottom bg-white shadow-sm">
  <div class="container d-flex flex-wrap justify-content-between align-items-center">
    <!-- Home 아이콘 & 타이틀 -->
    <a href="<c:url value='/welcome.jsp'/>" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
      <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-house-fill me-2" viewBox="0 0 16 16">
        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a1 1 0 0 0 .708.708L8 2.207 14.646 8.854a1 1 0 0 0 .708-.708L8.707 1.5Z"/>
        <path d="M8 3.293l6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 1 13.5V9.293l6-6z"/>
      </svg>
      <span class="fs-4 fw-semibold">책속의 밤</span>
    </a>

    <!-- 네비게이션 -->
    <ul class="nav">
      <li class="nav-item">
        <a class="nav-link text-primary" href="<c:url value='/books.jsp'/>">도서 목록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-primary" href="<c:url value='/guide.jsp'/>">이용 방법</a>
      </li>

      <!-- 로그인 여부 -->
      <c:choose>
        <c:when test="${empty sessionScope.userId}">
          <li class="nav-item">
            <a class="nav-link text-primary" href="<c:url value='/member/login.jsp'/>">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-primary" href="<c:url value='/member/register.jsp'/>">회원가입</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="nav-item">
            <a class="nav-link text-primary" href="<c:url value='/cart.jsp'/>">장바구니</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-primary" href="<c:url value='/member/myOrder.jsp'/>">주문내역</a>
          </li>
          <li class="nav-item pt-2 px-2 text-muted">[${sessionScope.userId}님]</li>
          <li class="nav-item">
            <a class="nav-link text-danger" href="<c:url value='/member/logout.jsp'/>">로그아웃</a>
          </li>
          <!-- 관리자 메뉴 -->
          <c:if test="${sessionScope.role == 'admin'}">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-danger" href="#" id="adminMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                관리자 메뉴
              </a>
              <ul class="dropdown-menu" aria-labelledby="adminMenu">
                <li><a class="dropdown-item" href="<c:url value='/addBook.jsp'/>">도서 등록</a></li>
                <li><a class="dropdown-item" href="<c:url value='/updateBook.jsp'/>">도서 수정</a></li>
                <li><a class="dropdown-item" href="<c:url value='/admin/orderManagement.jsp'/>">배송 관리</a></li>
              </ul>
            </li>
          </c:if>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</header>
