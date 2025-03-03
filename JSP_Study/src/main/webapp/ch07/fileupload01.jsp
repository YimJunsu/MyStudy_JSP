<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>File Upload</title>
</head>
<body><!-- multiprart 이용한 파일업로드 -->
	<form name="fileForm" method="post" enctype="multipart/form-data" action="fileupload01_process.jsp">
		<p> 이 름 : <input type="text" name="name">
		<p> 제 목 : <input type="text" name="Subject">
		<p> 파 일 : <input type="file" name="filename">
		<p> <input type="submit" value="파일 올리기">
	
	</form>
</body>
</html>