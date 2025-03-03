<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
	<% 
		// 고유한 세션 내장 객체의 아이디 가져오기
		String sessin_id=session.getId();
		// 세션 마지막 접근 시간
		long last_time=session.getLastAccessedTime();
		// 세션 생성 시간
		long start_time=session.getCreationTime();
		// 웹 사이트 머문 시간(ㅔ션 접속 시간)
		long used_time=(last_time - start_time) / 60000;
		
		out.println("세션 아이디 : " + sessin_id + "분<br>");
		out.println("요청 시작 시간 : " + start_time + "분<br>");
		out.println("요청 마지막 시간 : " + last_time + "분<br>");
		out.println("웹 사이트 경과 시간 : " + used_time + "분<br>");
	%>
</body>
</html>