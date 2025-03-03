<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
    <jsp:useBean id="person" class="ch04.com.dao.Person" scope="request"/>
	<p> 아이디 : <jsp:getProperty property="id" name="person" />
	<p> 이 름 : <jsp:getProperty property="name" name="person" />
</body>
</html>
