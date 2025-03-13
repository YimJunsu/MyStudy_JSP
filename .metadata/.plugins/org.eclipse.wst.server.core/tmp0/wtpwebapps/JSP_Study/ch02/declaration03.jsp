<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%! // 선언문 태그
		String makeItLower(String data){
		return data.toLowerCase();
	}%>
	<%
		// 스크립틀릿 태그
		out.println(makeItLower("Hello World"));
	%>
</body>
</html>