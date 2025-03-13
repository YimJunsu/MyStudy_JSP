<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Cookie</title> <!-- 쿠키 삭제 -->
</head>
<body> <!-- 객체 저장된 모든 쿠키 삭제 -->
		<% 
		Cookie[] cookies=request.getCookies();
		
		for(int i=0; i<cookies.length; i++){
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}
		response.sendRedirect("cookie02.jsp");
		%>
</body>
</html>