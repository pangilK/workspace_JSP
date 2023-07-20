<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<html>
<head>
<meta charset="UTF-8">
<title>sqlDelete.jsp</title>
</head>
<body>
	<s:transaction dataSource="java/MySqlDB">
		<s:update var="result">
			DELETE FROM test_member WHERE num = ${param.num};
		</s:update>
	</s:transaction>
	
	<c:if test="${result == 1}">
		<script>
			alert('정상적으로 처리가 완료되었습니다.');
			location.href='sqlQuery.jsp';
		</script>
	</c:if>
</body>
</html>