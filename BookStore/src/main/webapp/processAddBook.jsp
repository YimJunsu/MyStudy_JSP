<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<% 
    request.setCharacterEncoding("UTF-8");
    
	// 파일 경로
	String filename="";
	String realFolder="D:\\Program files\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BookStore\\resources\\images";
	int maxSize=5*1024*1024;
	String encType="utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());


	String bookId = multi.getParameter("bookId"); // MultipartRequest를 통해 데이터 가져오기
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String author = multi.getParameter("author");
	String description = multi.getParameter("description");
	String publisher = multi.getParameter("publisher");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String releaseDate = multi.getParameter("releaseDate");
	String condition = multi.getParameter("condition");
    
    Enumeration files=multi.getFileNames();
    String fname=(String)files.nextElement();
    String fileName=multi.getFilesystemName(fname);
    
    Integer price;
    if (unitPrice == null || unitPrice.isEmpty()) {
        price = 0;
    } else {
        price = Integer.valueOf(unitPrice);
    }
    
    long stock;
    if (unitsInStock == null || unitsInStock.isEmpty()) {
        stock = 0;
    } else {
        stock = Long.valueOf(unitsInStock);
    }
    
    PreparedStatement ps = null;
    String sql = "INSERT INTO book VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    try {
        ps = conn.prepareStatement(sql);
        ps.setString(1, bookId);
        ps.setString(2, name);
        ps.setInt(3, price);
        ps.setString(4, author);
        ps.setString(5, description);
        ps.setString(6, publisher);
        ps.setString(7, category);
        ps.setLong(8, stock);
        ps.setString(9, releaseDate);
        ps.setString(10, condition);
        ps.setString(11, fileName);

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Data inserted successfully.");
        } else {
            System.out.println("Data insertion failed.");
        }
    } catch (SQLException e) {
        e.printStackTrace(); // SQL 오류 확인
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
    
    // 강제 이동
    response.sendRedirect("books.jsp");
%>
