<%@page import="vo.MemberVO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="common/error_page.jsp" %>
<%!
	// 선언문 - class block 영역
	// 선언된 변수는 field , method 선언도 가능
	String contextPath;
%>

<%
	contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Scope Project</title>
<%
	String message = (String) request.getAttribute("message");
	if(message != null){
		
%>
<script>
	alert('<%=message%>');
</script>
<% } %>
<style>
	table{
		border:2px solid black;
		border-radius:5px;
		margin:auto;
	}
	table *{
		margin:5px;
	}
	body{
		background: linear-gradient(to right,skyblue,deepPink);
	}
	a{
	    text-decoration:none;
	    color:black;
	    font-weight:bold;
	}
</style>
</head>
<body>
<header>
	<%
		List<MemberVO> memberList = (List<MemberVO>) application.getAttribute("memberList");
		if(memberList != null){
			for(MemberVO member : memberList){ %>
				<h2><%= member.toString() %></h2>
	<% 		} 
		} 
	%>
	
	<%
		// 로그인된 사용자 정보 확인
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
	%>
	
	<a href="<%=contextPath%>">MAIN PAGE</a> |
	<% 	if(loginMember != null){ %>
		<%=loginMember.getUname() %>님 반갑습니다. |
		<a href="logout.jsp">LOGOUT</a> 
	<%} else{%>
		<a href="<%=contextPath%>/join.jsp">JOIN PAGE</a> |
		<a href="<%=contextPath%>/login.jsp">LOGIN PAGE</a>
	<%} %>	
	<hr/>
</header>