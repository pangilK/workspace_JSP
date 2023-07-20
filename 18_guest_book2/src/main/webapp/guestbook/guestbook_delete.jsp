<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>방명록 메시지 삭제함</title>
</head>
<body>
<br/>
<!-- 삭제 확인 처리  알림 code 작성-->
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.InitialContext"%>
<%
	String resultMsg = "";
	String paramID = request.getParameter("id");
	String password = request.getParameter("password");
	
	Connection conn = ((DataSource)new InitialContext().lookup(
		"java:comp/env/java/MySqlDB"
	)).getConnection();
	
	PreparedStatement pstmt = null;
	
	try{
		pstmt = conn.prepareStatement(
			"DELETE FROM test_guestbook WHERE id = ? AND password = ?"
		);
		pstmt.setInt(1, Integer.parseInt(paramID));
		pstmt.setString(2, password);
		
		int result = pstmt.executeUpdate();
		resultMsg = (result > 0) ? "삭제 성공" : "삭제 실패";
	}catch(Exception e){
		resultMsg = "삭제 실패";
	}finally{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	String path = request.getContextPath();
%>
<h3><%=resultMsg%></h3>
<a href="<%=path%>/guestbook/guestbook_list.jsp">[목록 보기]</a>
</body>
</html>








