<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Database SQL</title>
</head>
<body>
	<%@include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		
		ResultSet rs=null;
		Statement stmt=null;
		
		try{
			String sql="SELECT INTO Member(id, pwd, name) VALUES('"+id+"','"+pwd+"','"+name+"')";
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			if(rs.next()){
				String rId=rs.getString("id");
				String rPwd=rs.getString("pwd");
			if(id.equals(rId) && pwd.equals(rPwd)){
				stmt=conn.createStatement();
				stmt.executeUpdate(sql);
				out.println("Member 테이블을 수정했습니다.");
			}else
				out.println("일치하는 비밀번호가 아닙니다.");
		} else
				out.println("Member 테이블에 일치하는 아이디가 없습니다.");
		}catch(SQLException ex){
			out.println("Member 테이블 삽입이 실패했습니다.");
			out.println("SQLException: " + ex.getMessage());
		}finally{
			if(rs!=null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
		}
	%>
</body>
</html>