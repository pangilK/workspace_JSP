<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sqlQuery.jsp</title>
</head>
<body>
	<c:catch var="e">
		<s:query var="r" dataSource="java/MySqlDB" sql="SELECT * FROM test_member ORDER BY num asc"/>
		<!-- r.rowCount == 검색이된 행의 개수 -->
		<c:choose>
			<c:when test="${r.rowCount > 0}">
				<h2>검색된 회원정보가 존재함 - ${r.rowCount}</h2>
				<c:forEach var="m" items="${r.rows}">
					${m.num} -
					${m.id} -
					${m.pass} -
					${m.addr} -
					${m.phone} -
					${m.gender} -
					${m.age} -
					<a href="sqlUpdate.jsp?num=${m.num}">수정</a> | 
					<a href="sqlDelete.jsp?num=${m.num}">삭제</a> 
					<hr/>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<h2>검색된 회원정보가 없다</h2>
			</c:otherwise>
		</c:choose>
	</c:catch>
	<c:if test="${!empty e}">
		<h3>검색 실패 - ${e}</h3>
	</c:if>
</body>
</html>