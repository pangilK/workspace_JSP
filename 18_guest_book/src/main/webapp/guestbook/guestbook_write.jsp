<%@page import="util.DBCPUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>방명록 메시지 작성 확인</title>
</head>
<body>
<%@ page import="javax.sql.*, javax.naming.*, java.sql.*" %>
<!-- 방명록 작성 후 처리 결과 출력 code 작성 -->
<% 
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String message = request.getParameter("message");
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	String resultMsg = "";
	
	try{
		pstmt = conn.prepareStatement(
			"INSERT INTO test_guestbook VALUES(null,?,?,?)"
		);	
		pstmt.setString(1,name);
		pstmt.setString(2,pw);
		pstmt.setString(3,message);
		
		int result = pstmt.executeUpdate();
		
		resultMsg = (result > 0) ? "방명록 등록 성공" : "방명록 등록 실패";
		
	}catch(Exception e){
		resultMsg = "방명록 등록 실패";
	}finally{
		DBCPUtil.close(pstmt,conn);
	}
%>

<!-- 방명록 작성 후 처리 결과 출력 code 작성 end-->
<h2><%=resultMsg%></h2>
<a href="guestbook_list.jsp">[목록 보기]</a>
</body>
</html>










