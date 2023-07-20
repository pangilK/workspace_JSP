<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sqlMember.jsp</title>
</head>
<body>
	
	<s:query var="rs" dataSource="java/MySqlDB">
		SELECT * FROM test_member WHERE num = ?
		<s:param>${param.num}</s:param>
	</s:query>
	<c:if test="${rs.rowCount > 0}">
		<c:set var="m" value="${rs.rows[0]}" />
		${m} <br/>
		${m.num} -
		${m.id} -
		${m.pass} -
		${m.name} -
		${m.addr} -
		${m.phone} -
		${m.gender} -
		${m.age}
	</c:if>
	<br/>
	<a href="sqlQuery.jsp">회원 목록</a>
</body>
</html>