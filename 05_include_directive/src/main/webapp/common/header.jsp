<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INCLUDE TEST</title>
</head>
<body>
	<header>
		<h1>HEADER JSP</h1>
		<hr/>
		<%-- <h3><%= result %></h3> --%>
		<!-- <a href="/05_include_directive">HOME</a> -->
		<a href="<%=request.getContextPath()%>">HOME</a>
		<a href="second.jsp">SECOND</a>
	</header>
<%!
	String s = "HEADER에 선언된 전역 변수 - FIELD";
%>