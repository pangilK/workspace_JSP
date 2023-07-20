<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!-- joinCheck.jsp -->
<!-- 회원가입 처리 -->
<!-- POST - 전달된 한글 처리 -->
<f:requestEncoding value="UTF-8"/>
<c:catch var="e">
	<jsp:useBean id="joinMember" class="vo.MemberVO"/>
	<jsp:setProperty property="*" name="joinMember"/>	
</c:catch>
<c:choose>
	<c:when test="${!empty e}">
		<script>
			alert('잘못된 회원정보입니다.');	
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<s:query var="rs" dataSource="java/MySqlDB">
			SELECT * FROM digital_member WHERE u_id = ?
			<s:param>${joinMember.u_id}</s:param> 
		</s:query>
		<c:choose>
			<c:when test="${rs.rowCount > 0}">
				<!-- 이미 사용중인 u_id -->
				<script>
					alert('이미 사용중인 아이디입니다.');
					history.go(-1);
				</script>
			</c:when>
			<c:otherwise>
				<s:update var="result" dataSource="java/MySqlDB">
					INSERT INTO digital_member(u_id,u_pass,u_age,u_gender) 
					VALUES(?,?,${joinMember.u_age},?)
					<s:param>${joinMember.u_id}</s:param>
					<s:param>${joinMember.u_pass}</s:param>
					<s:param>${joinMember.u_gender}</s:param>
				</s:update>
				<script>
					let result = '${result}';
					alert(result+"행 삽입완료");
					location.href="login.jsp";
				</script>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>









