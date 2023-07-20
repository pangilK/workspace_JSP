<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<!-- logout.jsp  -->
<%
 	 // session.removeAttribute("userName");
	 // invalidate() = 세션을 초기화시킴
	 session.invalidate();
     response.sendRedirect(request.getContextPath());
%>
