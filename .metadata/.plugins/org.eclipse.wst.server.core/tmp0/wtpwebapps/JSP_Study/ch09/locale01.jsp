<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Internationalization</title>
</head>
<body>
    <h3>현재 로케일의 국가, 날짜, 통화</h3>
    <%
        Locale locale = request.getLocale();
        LocalDate currentDate = LocalDate.now();
        
        // 날짜 포맷
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy", locale);
        String formattedDate = currentDate.format(dateFormatter);
        
        // 숫자 포맷
        NumberFormat numberFormat = NumberFormat.getNumberInstance(locale);
    %>
    <p>국가: <%= locale.getDisplayCountry() %></p>
    <p>날짜: <%= formattedDate %></p>
    <p>숫자 (12345.67): <%= numberFormat.format(12345.67) %></p>
</body>
</html>
