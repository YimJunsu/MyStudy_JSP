<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	try{
	String url="jdbc:mariadb://localhost:3307/BookStoreJSP";
	String user="root";
	String password="070412Thu!";
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn=DriverManager.getConnection(url, user, password);
	
	} catch (SQLException ex) {
		out.println("데이터베이스 연결이 실패했습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	} 
%>