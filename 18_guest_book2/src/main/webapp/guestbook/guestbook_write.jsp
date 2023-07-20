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
	String guestName = request.getParameter("guestName");
	String password = request.getParameter("password");
	String message = request.getParameter("message");
	
	System.out.println(guestName);
	System.out.println(password);
	System.out.println(message);
	if(guestName != null && guestName.trim().equals("")) guestName = null;
	if(password != null && password.trim().equals("")) password = null;
	if(message != null && message.trim().equals("")) message = null;
	
	DataSource ds = (DataSource)new InitialContext().lookup(
		"java:comp/env/java/MySqlDB"
	);
	
	Connection conn = ds.getConnection();
	System.out.println(conn);
	PreparedStatement pstmt = null;
	String resultMsg = "";
	try{
		pstmt = conn.prepareStatement(
			"INSERT INTO test_guestbook VALUES(null,?,?,?)"
		);	
		pstmt.setString(1,guestName);
		pstmt.setString(2,password);
		pstmt.setString(3,message);
		
		int result = pstmt.executeUpdate();
		
		resultMsg = (result > 0) ? "방명록 등록 성공" : "방명록 등록 실패";
		
	}catch(Exception e){
		resultMsg = "방명록 등록 실패";
	}finally{
		
		if(pstmt != null) {
			pstmt.close();
		}
		
		if(conn != null){
			conn.close();
		}
	}
	
	String path = request.getContextPath();
%>

<!-- 방명록 작성 후 처리 결과 출력 code 작성 end-->
<h2><%=resultMsg%></h2>
<a href="<%=path%>/guestbook/guestbook_list.jsp">[목록 보기]</a>
</body>
</html>










