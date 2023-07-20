<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beansTest2</title>
</head>
<body>
	<form action="beanResult.jsp" method="post">
		이름 : <input type="text" name="name" /> <br />
		주소 : <input type="text" name="addr" /> <br />
		이메일 : <input type="email" name="email" required /> <br />
		나이 : <input type="number" name="age" min="1" max ="100" required/> <br />
		<button>쏘세요!</button>
	</form>
</body>
</html>