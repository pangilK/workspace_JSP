<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session" />
<jsp:useBean id="memberList" type="java.util.List<vo.MemberVO>" class="java.util.ArrayList" scope="application"/>
<!-- withdraw.jsp -->
<%
	request.setCharacterEncoding("utf-8");

	memberList.remove(loginMember);	
	session.removeAttribute("loginMember");
	Cookie cookie = new Cookie("rememberMe","");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<script> 
	location.href='index.jsp';
</script>







