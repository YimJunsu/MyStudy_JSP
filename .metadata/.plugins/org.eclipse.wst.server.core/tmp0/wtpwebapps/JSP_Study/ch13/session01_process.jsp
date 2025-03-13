<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
		<%
		String user_id = request.getParameter("id");
		String user_pwd = request.getParameter("pwd");
		
		if(user_id.equals("admin") && user_pwd.equals("1234")){
			session.setAttribute("userID", user_id);
			session.setAttribute("userPW", user_pwd);
			out.println("세션 설정이 성공했습니다<br>");
			out.println(user_id + "님 환영합니다.");
		} else {
			out.println("세션 설정이 실패했습니다.");
		}
		%>
</body>
</html>