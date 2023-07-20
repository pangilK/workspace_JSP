<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();
	String name = (String) session.getAttribute("name");
	/* 앞으로의 교훈 잘되는건 다신 건들지 말자 */
	if(cookies != null && (name == null || name.equals(""))){
		for(Cookie c : cookies){
			String cookie = c.getName();
			if(cookie.equals("id")){
				String id = c.getValue();
				List<vo.MemberVO> memberList = (List<vo.MemberVO>) application.getAttribute("memberList");
				if(memberList == null){
			 		out.println("<script>");
					out.println("location.href='delete.jsp'");
					out.println("</script>"); 
				}else{		
					for(vo.MemberVO m : memberList){
						String mId = m.getId();
						if(id.equals(mId)){
							name = m.getName();
							session.setAttribute("name",name);
						}
					}
				}
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
			<%
				if(name != null){
			%>
			<!-- 로그인 상태 -->
			<li><a href="info.jsp"> <%= name %> </a>님 반갑습니다.</li>
			<li><a href="logOut.jsp">로그아웃</a></li>
			<% } else { %>
			<!-- 비 로그인 상태 -->
		 	<li><a href="login.jsp">로그인</a></li>
		 	<li><a href="join.jsp">회원가입</a></li>
		 	<% } %>
		 </ul>
 </header>
 
 
 
 
 
 