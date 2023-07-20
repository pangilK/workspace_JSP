<%@page import="java.util.Base64"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<jsp:useBean id="memberList" class="java.util.ArrayList" type="java.util.List<vo.MemberVO>" scope="application"/>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null && loginMember.getId() == null && !memberList.isEmpty()){
		for(Cookie c : cookies){
			if(c.getName().equals("rememberMe")){
				
				// BASE64 ASCII 문자로 표현된 문자를 원본 문자로 복원 
				byte[] encodedID = Base64.getDecoder().decode(c.getValue().getBytes());
				String id = new String(encodedID);
				
				int index = memberList.indexOf(new MemberVO(id));
				loginMember = memberList.get(index);
				session.setAttribute("loginMember",loginMember);
				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/common.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		 <ul>
		 	<li><a href="index.jsp">HOME</a></li>
		 	<% if(loginMember.getId() != null) { %>
			<!-- 로그인 상태 -->
			<li><a href="index.jsp?page=info"> <!-- 회원이름 --> 
				<%= loginMember.getName() %></a>님 반갑습니다.</li>
			<li><a href="logOut.jsp">로그아웃</a></li>
			<% } else { %>
			<!-- 비 로그인 상태 -->
		 	<li><a href="index.jsp?page=login">로그인</a></li>
		 	<li><a href="index.jsp?page=join">회원가입</a></li>
		 	<% 
		 		session.removeAttribute("loginMember");		 	
				} %>
		 </ul>
 </header>
 
 
 
 
 
 