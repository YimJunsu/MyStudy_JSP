<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Cookie</title> <!-- 쿠키 설정 -->
</head>
<body>
		<%
		String user_id = request.getParameter("id");
		String user_pwd = request.getParameter("pwd");
		
		if(user_id.equals("admin")&&user_pwd.equals("1234")){
			Cookie cookie_id = new Cookie("userId" , user_id);
			Cookie cookie_pw = new Cookie("userPw" , user_pwd);
			response.addCookie(cookie_id);
			response.addCookie(cookie_pw);
			out.println(" 쿠키 생성이 성공했습니다 <br>");
			out.println(user_id + "님 환영합니다!");
		} else {
			out.println("쿠키 생성이 실패했습니다");
		}
		%>
</body>
</html>