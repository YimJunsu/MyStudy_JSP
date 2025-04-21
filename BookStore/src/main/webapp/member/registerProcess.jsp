<%@ page import="dao.MemberRepository, dto.Member" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    Member member = new Member();
    member.setId(request.getParameter("id"));
    member.setPassword(request.getParameter("password"));
    member.setName(request.getParameter("name"));
    member.setEmail(request.getParameter("email"));
    member.setZipcode(request.getParameter("zipcode"));
    member.setAddress1(request.getParameter("address1"));
    member.setAddress2(request.getParameter("address2"));

    try {
        MemberRepository repo = new MemberRepository();
        repo.save(member);
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('회원가입 중 오류가 발생했습니다.'); history.back();</script>");
    }
%>
