<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/menu.jsp"/>

<div class="container mt-5">
    <!-- 에러 메시지 표시 -->
    <%
        String error = request.getParameter("error");
        if ("1".equals(error)) {
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            아이디 또는 비밀번호가 올바르지 않습니다.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>
    <!-- 로그인 폼 -->
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">로그인</h4>
                </div>
                <div class="card-body">
                    <form action="loginProcess.jsp" method="post">
                        <div class="mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" name="id" id="id" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (alert 닫기용) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
