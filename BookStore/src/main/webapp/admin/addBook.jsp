<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userId = (String) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // 로그인 안 했거나, 권한이 admin이 아니면
    if (userId == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("exceptionNoPage.jsp");
        return;  // 리다이렉트 후 JSP 처리 종료
    }   
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
    <title>도서 등록</title>
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>'/>
<fmt:bundle basename="bundle.message">
<div class="container py-4">
    <jsp:include page="/menu.jsp"></jsp:include>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="title"/>도서 등록</h1>
            <p class="col-md-8 fs-4">Book Addition</p>
        </div>
    </div>

    <div class="row align-items-md-stretch">
        <div class="text-end">
            <a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
        </div>
        <form name="newBook" method="post" enctype="multipart/form-data" action="/BookStore/processAddBook.jsp" onsubmit="return CheckAddBook();">
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="bookId"/></label>
                <div class="col-sm-3">
                    <input type="text" id="bookId" name="bookId" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="name"/></label>
                <div class="col-sm-3">
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="unitPrice"/></label>
                <div class="col-sm-3">
                    <input type="text" id="unitPrice" name="unitPrice" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="author"/></label>
                <div class="col-sm-3">
                    <input type="text" name="author" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="publisher"/></label>
                <div class="col-sm-3">
                    <input type="text" name="publisher" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="releaseDate"/></label>
                <div class="col-sm-3">
                    <input type="text" name="releaseDate" class="form-control" placeholder="YYYY-MM-DD" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="description"/></label>
                <div class="col-sm-3">
                    <textarea rows="2" cols="50" name="description" id="description" class="form-control" placeholder="100자 이상 적어주세요" required></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="category"/></label>
                <div class="col-sm-3">
                    <input type="text" name="category" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
                <div class="col-sm-3">
                    <input type="text" id="unitsInStock" name="unitsInStock" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="condition"/></label>
                <div class="col-sm-5">
                    <input type="radio" name="condition" value="New"><fmt:message key="condition_New"/>
                    <input type="radio" name="condition" value="Old"><fmt:message key="condition_Old"/>
                    <input type="radio" name="condition" value="EBook"><fmt:message key="condition_Ebook"/>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="bookImage"/></label>
                <div class="col-sm-5">
                    <input type="file" name="bookImage" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="<fmt:message key='button'/>">
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</fmt:bundle>
</body>
</html>
