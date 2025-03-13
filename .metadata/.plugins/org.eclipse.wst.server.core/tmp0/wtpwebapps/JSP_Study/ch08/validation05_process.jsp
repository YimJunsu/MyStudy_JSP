<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Validation</title>
</head>
<body>
	<h3>입력에 성공했습니다.</h3>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<p> 아이디 : <%=request.getParameter("id") %>
	<p> 비밀번호 : <%=request.getParameter("passwd") %>
	<p> 이름 : <%=request.getParameter("name") %>
	<p> 연락처 : <%=request.getParameter("phone1") %>-<%=request.getParameter("phone2") %>-<%=request.getParameter("phone3") %>
	<p> 이메일 : <%=request.getParameter("email") %>
</body>
</html>