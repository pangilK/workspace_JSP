<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test/test_null.jsp</title>
</head>
<body>
	<%
		String s = request.getParameter("a");
		if(s.equals("aa")){
			out.println(s);
		}
	%>
</body>
</html>