<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%	
		// 스크립틀릿 태그에 지역변수 사용
		int a=2;
		int b=3;
		int sum=a+b;
		out.println("2+3="+sum);
	%>
</body>
</html>