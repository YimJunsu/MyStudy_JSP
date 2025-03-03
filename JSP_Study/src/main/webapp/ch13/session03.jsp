<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Session</title> <!-- 세션 -->
</head>
<body>
		<%
		String name;
		String value;
		
		Enumeration en = session.getAttributeNames();
		int i = 0;
		// 저장된 세션 속성 이름이 있을 때 까지
		while(en.hasMoreElements()) {
			i++;
			name=en.nextElement().toString();
			value=session.getAttribute(name).toString();
			out.println("설정된 세션의 속성 이름 [" + i + "] : " + name + "<br>");
			out.println("설정된 세션의 속성 값 [" + i + "] : " + value + "<br>");
		}
		%>
</body>
</html>