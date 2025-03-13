<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%!	// 선언문 태그 - 자바 코드 / 전역 메소드 선언 
		int sum(int a, int b){
		return a+b;
	 } %>
	 <%
	 	// 스크립틀릿 태그 - sum 메소드 2, 3 각각 대입
	 	out.println("2+3="+sum(2,3));
	 %>
</body>
</html>