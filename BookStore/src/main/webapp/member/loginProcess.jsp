<%@ page import="dao.MemberRepository, dto.Member" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String password = request.getParameter("password");

    try {
        MemberRepository repo = new MemberRepository();
        Member loginUser = repo.findByIdAndPassword(id, password);
        System.out.println("Debug: 로그인 결과 = " + loginUser); // 콘솔 출력
        if (loginUser != null) {
            session.setAttribute("sessionId", loginUser.getId());
            session.setAttribute("role", loginUser.getRole());  // ✅ role 추가!
            response.sendRedirect("../welcome.jsp");
        } else {
            out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); location.href='login.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('로그인 중 오류 발생!'); history.back();</script>");
    }
%>
