<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>알수 없는 오류</h1>
	<h3>이용에 불편을 드려 죄송합니다.</h3>
	<h4>(--)(__)(--);</h4>
	<a href="index.jsp">main 으로</a>
	<%= exception.getMessage() %>
</body>
</html>