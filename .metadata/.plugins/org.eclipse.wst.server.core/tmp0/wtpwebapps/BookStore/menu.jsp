<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    System.out.println("Debug: userId = " + (String) session.getAttribute("userId") + ", role = " + sessionRole);
%>

<header class="py-3 mb-4 border-bottom bg-white shadow-sm">
  <div class="container d-flex flex-wrap justify-content-between align-items-center">
    
    <!-- 아이콘 이미지 + 타이틀 -->
    <a href="<c:url value='/welcome.jsp'/>" class="d-flex align-items-center mb-2 mb-lg-0 text-decoration-none">
      <img src="https://cdn-icons-png.flaticon.com/512/1086/1086933.png" width="32" height="32" class="me-2" alt="홈 아이콘">
      <span class="fs-4 fw-semibold" style="color: #6366f1;">지식의방</span>
    </a>

    <!-- 네비게이션 -->
    <ul class="nav">
      <li class="nav-item">
        <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/books.jsp'/>">도서 목록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/guide.jsp'/>">이용 방법</a>
      </li>

      <c:choose>
        <c:when test="${empty sessionScope.userId}">
          <li class="nav-item">
            <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/member/login.jsp'/>">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/member/register.jsp'/>">회원가입</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="nav-item">
            <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/cart.jsp'/>">장바구니</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" style="color: #6366f1; font-weight: bold;" href="<c:url value='/member/myOrder.jsp'/>">주문내역</a>
          </li>
          <li class="nav-item pt-2 px-2" style="color: #6b7280; font-weight: bold;">[${sessionScope.userId}님]</li>
          <li class="nav-item">
            <a class="nav-link text-danger" style="font-weight: bold;" href="<c:url value='/member/logout.jsp'/>">로그아웃</a>
          </li>

          <!-- 관리자 메뉴 -->
          <c:if test="${sessionScope.role == 'admin'}">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" style="color: #a855f7; font-weight: bold;" href="#" id="adminMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                관리자 메뉴
              </a>
              <ul class="dropdown-menu" aria-labelledby="adminMenu">
                <li><a class="dropdown-item" style="font-weight: bold;" href="<c:url value='/admin/addBook.jsp'/>">도서 등록</a></li>
                <li><a class="dropdown-item" style="font-weight: bold;" href="<c:url value='/admin/updateBook.jsp'/>">도서 수정</a></li>
                <li><a class="dropdown-item" style="font-weight: bold;" href="<c:url value='/admin/orderManagement.jsp'/>">배송 관리</a></li>
              </ul>
            </li>
          </c:if>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</header>
