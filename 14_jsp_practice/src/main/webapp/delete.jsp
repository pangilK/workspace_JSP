<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Cookie cookie = new Cookie("id","");
	cookie.setMaxAge(0);
	cookie.setPath("/");
	response.addCookie(cookie);
	response.sendRedirect("index.jsp");
%>