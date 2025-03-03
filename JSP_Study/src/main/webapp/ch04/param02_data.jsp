<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
	<%
		String title = request.getParameter("title");
		// URLDecoder.decode()에서 UTF-8을 명시적으로 지정
		String decodedTitle = java.net.URLDecoder.decode(title, "UTF-8");  
	%>
	<h3><%= decodedTitle %></h3>
</body>
</html>
