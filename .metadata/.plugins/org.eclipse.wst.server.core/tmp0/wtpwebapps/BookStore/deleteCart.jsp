<%@page import="dto.Book"%>
<%@page import="dao.BookRepository"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
	String id = request.getParameter("cartId");
	if(id==null || id.trim().equals("")){
		response.sendRedirect("cart.jsp"); // 전송된 cartId 가 없을때, 웹페이지 cart.jsp로 이동
		return;
	}
	
	session.invalidate(); // 세션 등록된 모든 도서 삭제
	response.sendRedirect("cart.jsp");
%>