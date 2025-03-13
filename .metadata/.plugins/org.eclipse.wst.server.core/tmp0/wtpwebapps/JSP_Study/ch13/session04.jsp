<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
		<h4>-----세션 삭세하기 전----</h4>
		<%
		String user_id = (String) session.getAttribute("userID");
		String user_pwd = (String) session.getAttribute("userPW");
		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPWD : " + user_pwd + "<br>");
		
		session.removeAttribute("userID");
		%>
		<h4>-----세션 삭제한 후-----</h4>
		<%
		user_id = (String) session.getAttribute("userID");
		user_pwd = (String) session.getAttribute("userPW");
		out.println("설정된 세션 이름 userID : " + user_id + "<br>");
		out.println("설정된 세션 값 userPWD : " + user_pwd + "<br>");
		
		session.removeAttribute("userID");
		%>
</body>
</html>