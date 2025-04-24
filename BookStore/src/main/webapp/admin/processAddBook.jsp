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
    
    // 실제 저장 경로 설정
    String uploadPath = application.getRealPath("/resources/images");
    System.out.println("업로드 경로: " + uploadPath);
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        boolean created = uploadDir.mkdirs();
        System.out.println("디렉토리 생성 결과: " + created);
    }
    
    // 숫자 변환
    Integer price = (unitPriceStr != null && !unitPriceStr.isEmpty()) ? Integer.valueOf(unitPriceStr) : 0;
    Long stock = (unitsInStockStr != null && !unitsInStockStr.isEmpty()) ? Long.valueOf(unitsInStockStr) : 0;

    try {
        // 파일 업로드 처리 - bookImage로 필드명 수정
        Part filePart = request.getPart("bookImage");
        System.out.println("파일 파트: " + (filePart != null ? "찾음" : "없음"));
        
        if (filePart != null) {
            System.out.println("파일 크기: " + filePart.getSize());
        }
        
        if (filePart != null && filePart.getSize() > 0) {
            // 파일명 추출
            String contentDisp = filePart.getHeader("content-disposition");
            System.out.println("Content-Disposition: " + contentDisp);
            
            String[] items = contentDisp.split(";");
            for (String item : items) {
                if (item.trim().startsWith("filename")) {
                    fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                    // 경로 정보 제거
                    fileName = fileName.substring(Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\')) + 1);
                    System.out.println("추출된 파일명: " + fileName);
                    break;
                }
            }
            
            if (fileName != null && !fileName.isEmpty()) {
                File destFile = new File(uploadDir, fileName);
                System.out.println("저장할 파일 경로: " + destFile.getAbsolutePath());
                
                // 스트림을 통한 직접 파일 저장
                try (InputStream input = filePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(destFile)) {
                    
                    byte[] buffer = new byte[8192];
                    int bytesRead = 0;
                    long totalBytes = 0;
                    
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                        totalBytes += bytesRead;
                    }
                    
                    System.out.println("파일 저장 완료: " + destFile.getAbsolutePath());
                    System.out.println("저장된 바이트 수: " + totalBytes);
                }
            }
        }

        // 데이터베이스 저장
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO book (book_id, name, unit_price, author, description, publisher, category, units_in_stock, release_date, `condition`, filename, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
        ps.setInt(12, 0);  // 초기 수량 0
        
        int result = ps.executeUpdate();
        
        if (ps != null) ps.close();
        if (conn != null) conn.close();
        
        if (result > 0) {
            response.sendRedirect("../books.jsp");
        } else {
            out.println("<script>alert('도서 등록에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage().replaceAll("'", "\\\\'") + "'); history.back();</script>");
    }
%>