<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/books.css" rel="stylesheet" type="text/css">
<title>도서 목록</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="books-hero text-center">
        <h1 class="fw-bold">도서 목록</h1>
        <p class="fs-4 text-muted">모든 책을 한눈에 살펴보세요 📚</p>
        <p class="book-count" id="bookCount"></p>
    </div>

    <%@ include file="dbconn.jsp" %>
    <div class="row row-cols-1 row-cols-md-3 g-4 text-center">
        <%
        PreparedStatement ps = null;
        ResultSet rs = null;
        int bookCount = 0;
        try {
            String sql = "SELECT * FROM book";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                bookCount++;
        %>
        <div class="col">
            <div class="card h-100 book-card shadow-sm">
                <div class="book-image-container">
                    <img src="resources/images/<%=rs.getString("filename") != null ? rs.getString("filename") : "default.jpg" %>" 
                         class="card-img-top book-image" alt="도서 이미지">
                </div>
                <div class="card-body">
                    <h5 class="card-title book-title"><%=rs.getString("name") %></h5>
                    <p class="card-text book-author">
                        <span class="author"><%=rs.getString("author") %></span> | 
                        <span class="publisher"><%=rs.getString("publisher") %></span>
                    </p>
                    <%
                    String desc = rs.getString("description");
                    if (desc != null && desc.length() > 60) {
                        desc = desc.substring(0, 60) + "...";
                    }
                    %>
                    <p class="card-text book-description"><%=desc %></p>
                    <p class="book-price"><%=rs.getInt("unit_price") %>원</p>
                    <a href="./book.jsp?id=<%=rs.getString("book_id") %>" class="btn btn-book-detail">상세 정보 &raquo;</a>
                </div>
            </div>
        </div>
        <%
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>오류 발생: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { }
            if (ps != null) try { ps.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
        %>
    </div>

    <%@ include file="footer.jsp" %>
</div>

<script>
    // 도서 개수 표시
    document.getElementById('bookCount').innerText = "총 <%=bookCount%>개의 도서가 있습니다";
</script>
</body>
</html>