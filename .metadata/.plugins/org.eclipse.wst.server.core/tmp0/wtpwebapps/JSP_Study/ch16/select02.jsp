<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Database SQL</title>
</head>
<body>
	<%@include file="dbconn.jsp" %>
	<table width="300" border="1">
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
		</tr>
		<%
			ResultSet rs = null;
			PreparedStatement ps = null;
			
		try{
			String sql="SELECT * FROM Member";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery(sql);
			
			while (rs.next()) {
				String id=rs.getString("id");
				String pwd=rs.getString("pwd");
				String name=rs.getString("name");
		%>
		<tr>
			<td><%=id %></td>
			<td><%=pwd %></td>
			<td><%=name %></td>
		</tr>
		<%
			}
		}catch (SQLException ex) {
			out.println("Member 테이블 호출이 실패했습니다.<br>");
			out.println("SQLException: " + ex.getMessage());
		} finally {
			if(rs != null)
				rs.close();
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
		%>
	</table>
</body>
</html>

