<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<!-- memberUpdate.jsp -->
<%
	String num = request.getParameter("num");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	
	PreparedStatement pstmt = null;
	int result = 0;
	try{		
        pstmt = conn.prepareStatement(
                "UPDATE test_member SET id = ?, pass = ?, name = ?, addr = ?, phone = ?, gender = ?, age = ? WHERE num = ?");
        pstmt.setString(1, id);
        pstmt.setString(2, pass);
        pstmt.setString(3, name);
        pstmt.setString(4, addr);
        pstmt.setString(5, phone);
        pstmt.setString(6, gender);
        pstmt.setInt(7, Integer.parseInt(age));
        pstmt.setInt(8, Integer.parseInt(num));
        
        result = pstmt.executeUpdate();
	}catch(Exception e){
		out.println("<script>");
		out.println("alret('수정작업 실패');");
		out.println("history.go(-1);");
		out.println("</script>");
	}finally{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
%>
<script>
	alert('<%=result%>개의 행 수정완료!');
	location.href = 'index.jsp?page=memberList';
</script>