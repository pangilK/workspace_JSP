<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<!-- updateExcute.jsp -->
<%
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	
	PreparedStatement pstmt = null;
	int result = 0;
	try{		
		pstmt = conn.prepareStatement(
				"UPDATE member SET name = ? , addr = ? WHERE num = ?");
		pstmt.setString(1,name);
		pstmt.setString(2,addr);
		pstmt.setInt(3,Integer.parseInt(num));
		
		// "UPDATE meber SET name = '"+name+"' , addr = '"+addr+"' , WHERE num = '"+num+"' "; 
		// 등록된 수정 질의(query) 수행 하고 수정된 행의 개수 반환
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
	location.href = 'memberList.jsp';
</script>