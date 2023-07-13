<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<jsp:useBean id="joinMember" class="vo.MemberVO" />
<jsp:setProperty name="joinMember" property="*"/>
<%
	PreparedStatement pstmt = null;
	String name = null;
	Statement stmt = null;
	List<String> idL = new ArrayList<>();
	
	try{		
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT id FROM test_member");
		
		while(rs.next()){
			String id = rs.getString("id");
			idL.add(id);
		}
		
		for(String id : idL){
			if(id.equals(joinMember.getId())){
				out.println("<script>");
				out.println("alert('이미 사용하고 있는 아이디입니다.')");
				out.println("history.go(-1)");
				out.println("</script>");
				return;
			}
		}
		
		pstmt = conn.prepareStatement(
				"INSERT INTO TEST_MEMBER(id,pass,name,addr,phone,gender,age) values(?,?,?,?,?,?,?)");
		pstmt.setString(1,joinMember.getId());
		pstmt.setString(2,joinMember.getPass());
		pstmt.setString(3,joinMember.getName());
		pstmt.setString(4,joinMember.getAddr());
		pstmt.setString(5,joinMember.getPhone());
		pstmt.setString(6,joinMember.getGender());
		pstmt.setInt(7,joinMember.getAge());
		pstmt.executeUpdate();
	}catch(Exception e){
		out.println("<script>");
		out.println("alret('회원가입 실패');");
		out.println("history.go(-1);");
		out.println("</script>");
	}finally{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
%>
<script>
	alert('회원가입 완료');
	location.href = 'index.jsp?page=login';
</script>