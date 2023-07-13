<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<!-- delete.jsp -->
<%
	String num = request.getParameter("num");

	PreparedStatement pstmt = conn.prepareStatement("DELETE FROM test_member where num = ?");
	pstmt.setInt(1,Integer.parseInt(num));

	pstmt.executeUpdate();
%>
<script>
	alert('삭제 완료');
	location.href='index.jsp?page=memberList';
</script>