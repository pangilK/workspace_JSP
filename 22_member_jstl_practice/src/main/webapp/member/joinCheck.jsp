<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!-- joinCheck.jsp -->
<!-- 회원가입 처리 -->
<s:setDataSource var="conn"
		driver="com.mysql.cj.jdbc.Driver" 
		url="jdbc:mysql://localhost:3306/digital_jsp"
		user="digital"
		password="12345" />
<s:update var="result" dataSource="${conn}">
		INSERT INTO digital_member(u_id,u_pass,u_age,u_gender) VALUES(?,?,?,?);
		<s:param>${param.u_id}</s:param>
		<s:param>${param.u_pass}</s:param>
		<s:param>${param.u_age}</s:param>
		<s:param>${param.u_gender}</s:param>
</s:update>

<c:if test="${result > 0}">
	<script>
		alert('회원가입 완료');
		location.href='login.jsp';
	</script>
</c:if>

<c:if test="${result == 0}">
	<script>
		alert('회원가입 실패');
		location.href='join.jsp';
	</script>
</c:if>








