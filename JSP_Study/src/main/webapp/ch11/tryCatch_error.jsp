<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Exception</title> <!-- 예외처리, 에러페이지 -->
</head>
<body>
	<p> 잘못된 데이터가 입력되었습니다.
	<p> <%=" 숫자 1 : " + request.getParameter("num1") %>
	<p> <%=" 숫자 2 : " + request.getParameter("num2") %>
</body>
</html>