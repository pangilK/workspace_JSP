<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTest2.jsp</title>
</head>
<body>
	<%
		String resultPage = request.getParameter("resultPage");
		/* 	
		String name = request.getParameter("name");
		name = URLEncoder.encode(name,"UTF-8");
		response.sendRedirect(resultPage+"?name="+name); 
		*/
	%>
	<jsp:forward page="<%=resultPage%>" > 
		<jsp:param name="tel" value="010-1234-5678"/>
	</jsp:forward>
</body>
</html>