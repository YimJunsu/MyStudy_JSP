<%@ page contentType="text/html; charset=utf-8" %>
<%
	String userId = (String) session.getAttribute("userId");
	String role = (String) session.getAttribute("role");
	
	// 로그인 안 했거나, 권한이 admin이 아니면
	if (userId == null || role == null || !"admin".equals(role)) {
	    response.sendRedirect("exceptionNoPage.jsp");
	    return;  // 리다이렉트 후 JSP 처리 종료
	}	
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>도서 수정</title>
</head>
<body>
<div class="container py-4">
    <%@include file="/menu.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="title"/>도서 수정</h1>
            <p class="col-md-8 fs-4">Book Updating</p>
        </div>
    </div>
    <%@ include file="/dbconn.jsp" %>
    <%
        String bookId = request.getParameter("id");
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM book WHERE b_id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, bookId);

        rs = ps.executeQuery();
        
        if (rs.next()) {
    %>
    <div class="row align-items-md-stretch">
        <div class="col-md-5">
            <img src="resources/images/<%= rs.getString("b_filename") %>" alt="image" style="width: 100%" />
        </div>
        <div class="col-md-7">
            <form name="newBook" action="./processUpdateBook.jsp" method="post" enctype="multipart/form-data">
            
            <div class="mb-3 row">
                <label class="col-sm-5">도서코드</label>
                <div class="col-sm-5">
                    <input type="text" id="bookId" name="bookId" class="form-control" value="<%= rs.getString("b_id") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">도서명</label>
                <div class="col-sm-3">
                    <input type="text" id="name" name="name" class="form-control" value="<%= rs.getString("b_name") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">가격</label>
                <div class="col-sm-5">
                    <input type="text" id="unitPrice" name="unitPrice" class="form-control" value="<%= rs.getString("b_unitPrice") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">저자</label>
                <div class="col-sm-5">
                    <input type="text" id="author" name="author" class="form-control" value="<%= rs.getString("b_author") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">출판사</label>
                <div class="col-sm-5">
                    <input type="text" id="publisher" name="publisher" class="form-control" value="<%= rs.getString("b_publisher") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">출판일</label>
                <div class="col-sm-5">
                    <input type="text" id="releaseDate" name="releaseDate" class="form-control" value="<%= rs.getString("b_releaseDate") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">상세정보</label>
                <div class="col-sm-8">
                    <textarea id="description" name="description" cols="50" rows="2" class="form-control" placeholder="100자 이상 적어주세요"><%= rs.getString("b_description") %></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">분류</label>
                <div class="col-sm-5">
                    <input type="text" id="category" name="category" class="form-control" value="<%= rs.getString("b_category") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-5">재고수</label>
                <div class="col-sm-5">
                    <input type="text" id="unitsInStock" name="unitsInStock" class="form-control" value="<%= rs.getString("b_unitsInStock") %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2">상태</label>
                <div class="col-sm-8">
                    <input type="radio" name="condition" value="New"/>신규도서
                    <input type="radio" name="condition" value="Old"/>중고도서
                    <input type="radio" name="condition" value="EBook"/>E-Book
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2">이미지</label>
                <div class="col-sm-8">
                    <input type="file" id="bookImage" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="등록"/>
                </div>
            </div>
            </form>
        </div>
    </div>
    <% 
        }
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    %>
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>
