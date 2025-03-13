<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%! // 선언문 태그 - 자바 코드 작성 
		int data = 50; %>
	<%
		// 스크립틀릿 태그 
		out.println("Value of the varialbe is:" + data);
	%>
</body>
</html>