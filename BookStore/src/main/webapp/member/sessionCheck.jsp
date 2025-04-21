<%@ page contentType="text/html; charset=utf-8" %>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("❌ 세션 없음. 로그인되지 않음.");
    } else {
        out.println("✅ 현재 세션 ID: " + sessionId);
    }
%>