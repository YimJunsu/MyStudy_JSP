<%@ page import="dao.MemberRepository, dto.Member" %>
<%
    String id = request.getParameter("id");
    String password = request.getParameter("password");

    MemberRepository repo = new MemberRepository();
    Member loginUser = repo.findByIdAndPassword(id, password);

    if (loginUser != null) {
        session.setAttribute("user", loginUser);
        response.sendRedirect("../welcome.jsp");
    } else {
        out.println("로그인 실패! <a href='login.jsp'>다시 시도</a>");
    }
%>
