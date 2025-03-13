<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>Internationalization</title>
</head>
<body>
    <jsp:useBean id="now" class="java.util.Date" scope="page"/>
    <p>현재 날짜: <fmt:formatDate value="${now}" type="date"/></p>
    <p>현재 시간: <fmt:formatDate value="${now}" type="time"/></p>
    <p>현재 날짜와 시간: <fmt:formatDate value="${now}" type="both"/></p>
    <p>기본 형식 (날짜와 시간): <fmt:formatDate value="${now}" type="both" dateStyle="default" timeStyle="default"/></p>
    <p>짧은 형식 (날짜와 시간): <fmt:formatDate value="${now}" type="both" dateStyle="short" timeStyle="short"/></p>
    <p>긴 형식 (날짜와 시간): <fmt:formatDate value="${now}" type="both" dateStyle="long" timeStyle="long"/></p>
    <p>전체 형식 (날짜와 시간): <fmt:formatDate value="${now}" type="both" dateStyle="full" timeStyle="full"/></p>
    <p>사용자 정의 형식 (날짜와 시간): <fmt:formatDate value="${now}" type="both" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초 E요일"/></p>
</body>
</html>
