<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<%
	String id = request.getParameter("id");
	if(id.equals("admin")){
		out.println("<script>");
		out.println("alert('응 안돼 돌아가')");
		out.println("history.back(-1)");
		out.println("</script>");
		return;
	}
	PreparedStatement pstmt = conn.prepareStatement("DELETE FROM test_member where id = ?");
	pstmt.setString(1,id);
	
	pstmt.executeUpdate();
	
	session.invalidate();

	Cookie cookie = new Cookie("rememberMe","");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<script>
	alert("회원 탈퇴 완료");
	location.href = 'index.jsp';
</script>