<%
    session.invalidate(); // 세션 삭제
    Cookie[] cookies = request.getCookies(); 

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("JSESSIONID".equals(cookie.getName())) {
                cookie.setMaxAge(0); // 쿠키 삭제
                cookie.setPath("/"); // 전체 경로에서 삭제되도록 설정
                response.addCookie(cookie);
            }
        }
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.sendRedirect("../welcome.jsp"); // 로그아웃 후 리디렉트
%>