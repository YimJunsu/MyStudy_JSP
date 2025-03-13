<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="java.io.*"%>
<html>
<head>
<title>File Upload</title>
</head>
<body> <!-- Commons-FileUpload를 이용한 업로드 방법 -->
	<%
		String fileUploadPath="D:\\Program files\\workspace\\upload";
		DiskFileUpload upload = new DiskFileUpload();
		List items = upload.parseRequest(request);
		
		Iterator params = items.iterator();
		
		while(params.hasNext()){
			FileItem fileItem = (FileItem) params.next();
			if(!fileItem.isFormField()){
				String fileName = fileItem.getName();
				fileName=fileName.substring(fileName.lastIndexOf("\\")+1);
				File file = new File(fileUploadPath + "/" + fileName);
				fileItem.write(file);
			}
		}
	%>
</body>
</html>