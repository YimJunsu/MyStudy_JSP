<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>File Upload</title>
</head>
<body> <!-- Commons-FileUpload를 이용한 업로드 방법 -->
	<form action="fileupload03_process.jsp" method="post" enctype="multipart/form-data">
		<p> 파 일 : <input type="file" name="filename">
		<p> <input type="submit" value="파일 올리기">
	</form>
</body>
</html>