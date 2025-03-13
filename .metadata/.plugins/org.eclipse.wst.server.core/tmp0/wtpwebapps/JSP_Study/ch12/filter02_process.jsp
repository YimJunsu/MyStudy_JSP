<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Filter</title> <!-- 필터, 로그 기록 -->
</head>
<body>
		<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		%>
		<p> 입력된 id 값 :<%=id %>
		<p> 입력된 pwd 값 :<%=passwd %>
</body>
</html>