<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sqlUpdate.jsp</title>
</head>
<body>
	
	<form action="sqlUpdateSubmit.jsp" method="post">
			<input type="hidden" name="num" value="${param.num}" />
			<h2>기존 비밀번호를 입력해 주세요.</h2>
			<input type="password" name="pass" />
			<h2>수정할 비밀번호를 입력해주세요</h2>
			password : <input type="password" name="rePass"/>
			<button>확인</button>
	</form>

</body>
</html>