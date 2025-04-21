<%@ page import="dao.MemberRepository, dto.Member" %>
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

    MemberRepository repo = new MemberRepository();
    repo.save(member);

    response.sendRedirect("login.jsp");
%>
