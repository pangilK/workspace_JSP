<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
<link rel = 'stylesheet' 
 href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"	
/>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<div class = "jumbotron">
		<div class = "container">
			<h1 class = "display-3">웹 쇼핑몰에 오신걸 환영합니다.</h1>
		</div>
	</div>
	
	<main role="main">
		<div class="container">
			<div class="text-center">
				<h3>Welcome to Web Market!</h3>
				<%
					Date day = new Date();
					String am_pm;
					int hour = day.getHours();
					int minute = day.getMinutes();
					int second = day.getSeconds();
					if( hour / 12 == 0 ){
						am_pm = "AM";
					} else {
						am_pm = "PM";
						hour = hour - 12;
					} 
					String CT = hour + ":" + minute + ":" + second + " " +am_pm;
					/* out.println("현재 접속 시각 : "+ CT + "\n"); */
				%>
				<%= "현재 접속 시각 : " + CT %>
			</div>
			<hr/>
		</div>
	</main>
	
	<%@ include file="footer.jsp" %>
</body>
</html>