<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>forwardTest.jsp</h1>
	<form action="forwardTest2.jsp" method="post">
		<input type="hidden" name="resultPage" value="forwardTest1.jsp" />
		이름 : <input type="text" name="name" required/> <br/>
		나이 : <input type="number" name="age" min="19" max="40" required/> <br/>
		<button>확인</button>
	</form>
</body>
</html>