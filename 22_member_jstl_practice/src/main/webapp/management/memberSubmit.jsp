<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- memberSubmit.jsp -->
<!-- 관리자 회원 정보 수정 완료 -->
<s:update var="result" dataSource="java/MySqlDB">
		UPDATE digital_member SET u_pass = ? , u_age = ? , u_gender = ? WHERE u_num = ?;
		<s:param>${param.u_pass}</s:param>
		<s:param>${param.u_age}</s:param>
		<s:param>${param.u_gender}</s:param>
		<s:param>${param.u_num}</s:param>
</s:update>
<c:choose>
	<c:when test="${result == 1}">
		<script>
			alert('수정완료');
			location.href='member.jsp';
		</script>
	</c:when>
	<c:otherwise>
			<script>
				alert('잘못된 정보입니다. 확인 후 요청해주세요.');
				history.go(-1);
			</script>
	</c:otherwise>
</c:choose>










