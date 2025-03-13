<%@ page contentType="text/html; charset=utf-8" %>
<%@ page isErrorPage="true" %>
<html>
<head>
<title>Exception</title> <!-- 예외처리, 에러페이지 -->
</head>
<body>
		<p> 오류가 발생하였습니다.
		<p> 예외 : <%=exception %>
		<p> toString() : <%=exception.toString() %>
		<p> getClass().getName() : <%=exception.getClass().getName() %>
		<p> getMessage() : <%=exception.getMessage() %>
</body>
</html>