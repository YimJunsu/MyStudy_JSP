<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
		<%
		String user_id = (String) session.getAttribute("userID");
		String user_pwd = (String) session.getAttribute("userPW");
		
		out.println("설정된 세션의 속성 값[1] : " + user_id + "<br>");
		out.println("설정된 세션의 속성 값[2] : " + user_pwd);
		
		%>
</body>
</html>