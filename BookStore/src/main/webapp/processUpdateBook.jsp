<%@ page import="java.sql.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="dbconn.jsp" %>


<%
	request.setCharacterEncoding("UTF-8");

	//파일 경로
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
    ResultSet rs = null;
    
    String sql="SELECT * FROM book WHERE b_id=?";
    ps=conn.prepareStatement(sql);
    ps.setString(1, bookId);
    rs=ps.executeQuery();
    
    if(rs.next()){
    	if(fileName != null) {
    		sql="UPDATE book SET b_name=?, b_unitPrice=?, b_author=?,b_description=?,b_publisher=?,b_category=?,b_unitsInStock=?,b_releaseDate=?,b_condition=?,b_fileName=? WHERE b_id?";
    		ps=conn.prepareStatement(sql);
    		ps.setString(1, name);
    		ps.setInt(2, price);
    		ps.setString(3, author);
    		ps.setString(4, description);
    		ps.setString(5, publisher);
    		ps.setString(6, category);
    		ps.setLong(7, stock);
    		ps.setString(8, releaseDate);
    		ps.setString(9, condition);
    		ps.setString(10, fileName);
    		ps.setString(11, bookId);
    		ps.executeUpdate();
    	} else {
    		sql="UPDATE book SET b_name=?, b_unitPrice=?, b_author=?,b_description=?,b_publisher=?,b_category=?,b_unitsInStock=?,b_releaseDate=?,b_condition=? WHERE b_id?";
    		ps=conn.prepareStatement(sql);
    		ps.setString(1, name);
    		ps.setInt(2, price);
    		ps.setString(3, author);
    		ps.setString(4, description);
    		ps.setString(5, publisher);
    		ps.setString(6, category);
    		ps.setLong(7, stock);
    		ps.setString(8, releaseDate);
    		ps.setString(9, condition);
    		ps.setString(10, bookId);
    		ps.executeUpdate();
    	}
    }
    if(ps!=null)
    	ps.close();
    if(conn != null)
    	conn.close();
%>

