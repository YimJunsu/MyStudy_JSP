<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="dbconn.jsp" %>
<%
    String bookId = request.getParameter("id");
    
    // 먼저 도서가 존재하는지 확인
    String sql = "SELECT * FROM book WHERE b_id=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, bookId);
    ResultSet rs = ps.executeQuery();

    // 도서가 존재하면 삭제
    if (rs.next()) {
        sql = "DELETE FROM book WHERE b_id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, bookId);
        ps.executeUpdate();
    } else {
        out.println("일치하는 도서가 없습니다.");
    }

    // 리소스 종료
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();

    // 삭제 후 editBook.jsp로 리다이렉트
    response.sendRedirect("editBook.jsp?edit=delete");
%>
