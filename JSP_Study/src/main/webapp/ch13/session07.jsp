<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
	<h4>----- 세션 유효 시간 변경 전 ----- </h4>
		<%
			int time=session.getMaxInactiveInterval() / 60;
		
			out.println("세션 유효 시간 : " + time + "분<br>");
		%>
	<h4>----- 세션 유효 시간 변경 후 ----- </h4>
		<%
		// 세션 유효시간을 60 * 60 초로 설정,
		session.setMaxInactiveInterval(60 * 60);	
		time=session.getMaxInactiveInterval() / 60;
			
			out.println("세션 유효 시간 : " + time + "분<br>");
		%>
</body>
</html>