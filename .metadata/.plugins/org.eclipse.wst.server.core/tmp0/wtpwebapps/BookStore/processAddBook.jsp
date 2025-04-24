<%@ page import="java.io.IOException"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

// 파일 저장 경로를 동적으로 가져오기
String uploadPath = application.getRealPath("/resources/images");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs(); // 디렉토리가 없으면 생성
}

int maxSize = 5 * 1024 * 1024;
String encType = "utf-8";

MultipartRequest multi = null;
try {
    multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
    System.out.println("파일 업로드 경로: " + uploadPath); // 로그 확인용
} catch (IOException e) {
    System.out.println("파일 업로드 오류: " + e.getMessage()); // 서버 로그에 기록
    out.println("<script>alert('파일 업로드 오류 발생: " + e.getMessage().replaceAll("\"", "\\\\\"") + "'); history.back();</script>");
    return;
}

// 파라미터 수집
String bookId = multi.getParameter("bookId");
String name = multi.getParameter("name");
String unitPriceStr = multi.getParameter("unitPrice");
String author = multi.getParameter("author");
String description = multi.getParameter("description");
String publisher = multi.getParameter("publisher");
String category = multi.getParameter("category");
String unitsInStockStr = multi.getParameter("unitsInStock");
String releaseDateStr = multi.getParameter("releaseDate");
String condition = multi.getParameter("condition");

// 파일명 처리
Enumeration<?> files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

// 파일이 제대로 업로드되었는지 확인
if (fileName != null) {
    File uploadedFile = new File(uploadPath, fileName);
    if (!uploadedFile.exists() || uploadedFile.length() == 0) {
        System.out.println("파일이 제대로 업로드되지 않음: " + uploadPath + File.separator + fileName);
    } else {
        System.out.println("파일 업로드 성공: " + uploadPath + File.separator + fileName + ", 크기: " + uploadedFile.length());
    }
} else {
    System.out.println("파일이 선택되지 않았거나 업로드 실패");
}

// 숫자 변환
int unitPrice = 0;
long unitsInStock = 0;
java.sql.Date releaseDate = null;

try {
    if (unitPriceStr != null && !unitPriceStr.isEmpty())
        unitPrice = Integer.parseInt(unitPriceStr);

    if (unitsInStockStr != null && !unitsInStockStr.isEmpty())
        unitsInStock = Long.parseLong(unitsInStockStr);

    if (releaseDateStr != null && !releaseDateStr.isEmpty())
        releaseDate = java.sql.Date.valueOf(releaseDateStr); // 형식: yyyy-MM-dd

} catch (Exception e) {
    System.out.println("입력값 형식 오류: " + e.getMessage());
    out.println("<script>alert('입력값 형식 오류입니다. 숫자 또는 날짜를 확인하세요'); history.back();</script>");
    return;
}

// DB 저장
PreparedStatement ps = null;
String sql = "INSERT INTO book (book_id, name, unit_price, author, description, publisher, category, units_in_stock, release_date, `condition`, filename, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

try {
    ps = conn.prepareStatement(sql);
    ps.setString(1, bookId);
    ps.setString(2, name);
    ps.setInt(3, unitPrice);
    ps.setString(4, author);
    ps.setString(5, description);
    ps.setString(6, publisher);
    ps.setString(7, category);
    ps.setLong(8, unitsInStock);
    ps.setDate(9, releaseDate);
    ps.setString(10, condition);
    ps.setString(11, fileName);
    ps.setInt(12, 0); // quantity 기본값

    int result = ps.executeUpdate();

    if (result > 0) {
        System.out.println("도서 등록 성공: " + bookId);
        response.sendRedirect("books.jsp");
    } else {
        System.out.println("도서 등록 실패: 영향받은 행이 없음");
        out.println("<script>alert('도서 등록 실패'); history.back();</script>");
    }

} catch (SQLException e) {
    System.out.println("SQL 오류: " + e.getMessage());
    e.printStackTrace();
    out.println("<script>alert('SQL 오류: " + e.getMessage().replaceAll("\"", "\\\\\"") + "'); history.back();</script>");
} finally {
    if (ps != null) try { ps.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
}
%>