<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>File Upload</title>
</head>
<body>
	
	<form name="fileForm" method="post" enctype="multipart/form-data" action="">	
		<p> 이 름 : <input type="text" name="name">
		<p>	제 목 : <input type="text" name="subject">
		<p>	파 일 : <input type="file" name="filename">
		<p> <input type="submit" value="파일 올리기">
	</form>
	
</body>
</html>w