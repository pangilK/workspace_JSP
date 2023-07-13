<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.* , util.*" %>
<jsp:useBean id="m" class="vo.MemberVO" scope="page"/>
<jsp:setProperty name="m" property="*"/>
<%
	Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
    
    String sql = "UPDATE test_member SET";
    	   sql += "id = ? ,";
    	   sql += "pass = ? ,";
    	   sql += "name = ? ,";
    	   sql += "addr = ? ,";
    	   sql += "phone = ? ,";
    	   sql += "gender = ? ,";
    	   sql += "age = ? WHERE num = ?";
   	
	 pstmt = conn.prepareStatement(sql);
	 pstmt.setString(1,m.getId());
	 pstmt.setString(2,m.getPass());
	 pstmt.setString(3,m.getName());
	 pstmt.setString(4,m.getAddr());
	 pstmt.setString(5,m.getPhone());
	 pstmt.setString(6,m.getGender());
	 pstmt.setInt(7,m.getAge());
	 pstmt.setInt(8,m.getNum());
	 
	 pstmt.executeUpdate();
	 DBCPUtil.close(pstmt,conn);
	 response.sendRedirect("index.jsp?page=memberList");
%>