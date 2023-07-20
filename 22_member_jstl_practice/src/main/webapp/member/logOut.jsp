<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <!-- 로그아웃 요청 처리 -->
<%
	// session 무효화
	session.invalidate();

	Cookie cookie = new Cookie("rememberMe","");
	cookie.setPath(request.getContextPath());
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<script>
	alert('로그아웃 완료');
	location.href='../index.jsp';
</script>