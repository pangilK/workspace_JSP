<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,util.*,java.sql.*"%>
<!-- memberDelete.jsp -->
<% 
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	int num = Integer.parseInt(request.getParameter("num"));
	int result = 0;
	
	try{
		pstmt = conn.prepareStatement("DELETE FROM test_member WHERE num = ?");
		pstmt.setInt(1,num);
		result = pstmt.executeUpdate();
		if(result == 0){
			throw new NullPointerException("삭제 회원 없음");
		}
	}catch(Exception e){
		out.println("<script>");
		out.println("alert('요청 처리 실패');");
		out.println("</script>");
	}finally{
		DBCPUtil.close(pstmt,conn);
		// response.sendRedirect("index.jsp?page=memberList");
		out.println("<script>");
		out.println("location.href='index.jsp?page=memberList';");
		out.println("</script>");
	}
%>
