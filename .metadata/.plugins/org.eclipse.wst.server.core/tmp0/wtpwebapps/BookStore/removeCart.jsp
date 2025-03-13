<%@page import="java.util.ArrayList"%>
<%@page import="dto.Book"%>
<%@page import="dao.BookRepository"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
	String id = request.getParameter("id");
	if(id==null || id.trim().equals("")){
		response.sendRedirect("books.jsp");
		return;
	}
	
	BookRepository dao = BookRepository.getInstance();
	
	// 만약에 도석 정보가 없으면 예외처리 페이지로 이동
	Book book=dao.getBookById(id);
	if(book==null){ 
		response.sendRedirect("exceptionNoBookId.jsp");
	}
	// 리스트에 등록된 모든 도서 가져오기
	ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
	Book goodsQnt=new Book();
	for(int i = 0; i < cartList.size(); i++){
		goodsQnt=cartList.get(i);
		if(goodsQnt.getBookId().equals(id)){ //요청 파라미터 아이디와 같으면 리스트에서 삭제
			cartList.remove(goodsQnt); 
		}
	}
	// 페이지 이동
	response.sendRedirect("cart.jsp");
%>