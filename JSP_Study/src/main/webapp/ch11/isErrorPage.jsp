<%@ page contentType="text/html; charset=utf-8" %>
<%@ page errorPage="isErrorPage_error.jsp" %>
<html>
<head>
<title>Exception</title> <!-- 예외처리, 에러페이지 -->
</head>
<body>
	name 파라미터 : <%=request.getParameter("name").toUpperCase() %>
</body>
</html>