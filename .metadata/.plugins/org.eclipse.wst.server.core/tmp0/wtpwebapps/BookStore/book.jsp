<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page errorPage="exceptionNoBookId.jsp" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/book.css" rel="stylesheet" type="text/css">
<title>도서 상세 정보</title>
<script type="text/javascript">
function addToCart() {
    if (confirm("도서를 장바구니에 추가하시겠습니까?")) {
        document.addForm.submit();
    } else {
        document.addForm.reset();
    }
}
</script>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="book-detail-hero">
        <h1 class="fw-bold text-center">도서 상세 정보</h1>
        <p class="text-muted text-center">책의 모든 정보를 확인하세요</p>
    </div>

    <%
    String id = request.getParameter("id");
    BookRepository dao = BookRepository.getInstance();
    Book book = dao.getBookById(id);

    if (book == null) {
        response.sendRedirect("exceptionNoBookId.jsp");
        return;
    }
    %>

    <div class="book-detail-container">
        <div class="row">
            <div class="col-md-5">
                <div class="book-image-container">
                    <img src="<%=request.getContextPath()%>/resources/images/<%=book.getFilename()%>" class="book-image">
                </div>
            </div>
            <div class="col-md-7">
                <div class="book-info">
                    <h2 class="book-title"><%=book.getName()%></h2>
                    <div class="book-badge">
                        <span class="badge book-id-badge"><%=book.getBookId()%></span>
                        <span class="category-badge"><%=book.getCategory()%></span>
                    </div>
                    
                    <div class="book-meta">
                        <p><span class="meta-label">저자</span> <span class="meta-value"><%=book.getAuthor()%></span></p>
                        <p><span class="meta-label">출판사</span> <span class="meta-value"><%=book.getPublisher()%></span></p>
                        <p><span class="meta-label">출판일</span> <span class="meta-value"><%=book.getReleaseDate()%></span></p>
                        <p><span class="meta-label">재고수</span> <span class="meta-value"><%=book.getUnitsInStock()%></span></p>
                    </div>
                    
                    <div class="book-price-container">
                        <p class="book-price"><%=book.getUnitPrice()%> <span class="currency">원</span></p>
                    </div>
                    
                    <div class="book-description">
                        <h4>도서 소개</h4>
                        <p><%=book.getDescription()%></p>
                    </div>
                    
                    <form name="addForm" action="./addCart.jsp?id=<%=book.getBookId()%>" method="post" class="action-buttons">
                        <a href="#" class="btn btn-order" onclick="addToCart()">도서 주문 &raquo;</a>
                        <a href="./cart.jsp" class="btn btn-cart">장바구니 &raquo;</a>
                        <a href="./books.jsp" class="btn btn-list">도서 목록 &raquo;</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</div>
</body>
</html>