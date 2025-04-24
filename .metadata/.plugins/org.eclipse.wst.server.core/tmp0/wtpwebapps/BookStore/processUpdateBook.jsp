<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    
    // 변수 초기화
    String bookId = request.getParameter("bookId");
    String name = request.getParameter("name");
    String unitPriceStr = request.getParameter("unitPrice");
    String author = request.getParameter("author");
    String description = request.getParameter("description");
    String publisher = request.getParameter("publisher");
    String category = request.getParameter("category");
    String unitsInStockStr = request.getParameter("unitsInStock");
    String releaseDate = request.getParameter("releaseDate");
    String condition = request.getParameter("condition");
    String fileName = null;
    
    // 숫자 변환
    Integer price = (unitPriceStr != null && !unitPriceStr.isEmpty()) ? Integer.valueOf(unitPriceStr) : 0;
    Long stock = (unitsInStockStr != null && !unitsInStockStr.isEmpty()) ? Long.valueOf(unitsInStockStr) : 0;

    try {
        // 파일 업로드 처리
        Part filePart = request.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            // 파일명 추출
            String contentDisp = filePart.getHeader("content-disposition");
            String[] items = contentDisp.split(";");
            for (String item : items) {
                if (item.trim().startsWith("filename")) {
                    fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                    // 경로 정보 제거
                    fileName = fileName.substring(Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\')) + 1);
                    break;
                }
            }
            
            if (fileName != null && !fileName.isEmpty()) {
                // 실제 저장 경로 설정
                String uploadPath = application.getRealPath("/resources/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                // 스트림을 통한 직접 파일 저장
                try (InputStream input = filePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(new File(uploadDir, fileName))) {
                    
                    byte[] buffer = new byte[8192];
                    int bytesRead = 0;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }
                
                System.out.println("파일 저장 완료: " + uploadPath + File.separator + fileName);
            }
        }

        // 데이터베이스 업데이트
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM book WHERE book_id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, bookId);
        rs = ps.executeQuery();

        if (rs.next()) {
            if (fileName != null && !fileName.isEmpty()) {
                sql = "UPDATE book SET name=?, unit_price=?, author=?, description=?, publisher=?, category=?, units_in_stock=?, release_date=?, `condition`=?, filename=? WHERE book_id=?";
                ps = conn.prepareStatement(sql);
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
            } else {
                sql = "UPDATE book SET name=?, unit_price=?, author=?, description=?, publisher=?, category=?, units_in_stock=?, release_date=?, `condition`=? WHERE book_id=?";
                ps = conn.prepareStatement(sql);
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
            }
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("editProduct.jsp?edit=update");
            } else {
                out.println("<script>alert('도서 수정에 실패했습니다.'); history.back();</script>");
            }
        } else {
            out.println("<script>alert('해당 도서를 찾을 수 없습니다.'); history.back();</script>");
        }
        
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage().replaceAll("'", "\\\\'") + "'); history.back();</script>");
    }
%>