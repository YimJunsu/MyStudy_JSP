<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
	<h4>----- 세션 삭제 전 ----- </h4>
		<%
		String user_id = (String) session.getAttribute("userID");
		String user_pwd = (String) session.getAttribute("userPW");
		
		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPWD : " + user_pwd + "<br>");
		
		if(request.isRequestedSessionIdValid()==true){
			out.print("세션이 유효합니다.");
		} else {
			out.print("세션이 유효하지 않습니다.");
		}
		session.invalidate();
		%>
	<h4>----- 세션 삭제 후 ----- </h4>
	<%
		if(request.isRequestedSessionIdValid()==true){
			out.print("세션이 유효합니다.");
		} else {
			out.print("세션이 유효하지 않습니다.");
		}
	%>
</body>
</html>