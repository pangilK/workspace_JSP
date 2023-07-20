<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- loginCheck.jsp -->
<!--
	 로그인 요청 처리 
	 로그인 성공한 회원의 정보를 member 를 키값으로 저장
-->
<s:query var="rs" dataSource="java/MySqlDB">
	SELECT * FROM digital_member WHERE u_id = ? and u_pass = ?; 
	<s:param>${param.u_id}</s:param>
	<s:param>${param.u_pass}</s:param>
</s:query>

<c:if test="${rs.rowCount > 0}">
	<c:if test="${rs.rows[0].u_join eq 'Y'}">
		<c:set var="member" value="${rs.rows[0]}" scope="session"/>
		<c:if test="${param.login ne null}">
			<%
				Cookie cookie = new Cookie("rememberMe",request.getParameter("u_id"));
				cookie.setPath(request.getContextPath());
				cookie.setMaxAge(60*60*24*10);
				response.addCookie(cookie);
			%> 
		</c:if>
		<script>
			alert('로그인 성공');
			location.href='../index.jsp';
		</script>
	</c:if>
	<c:if test="${rs.rows[0].u_join eq 'N'}">
			<script>
				if(confirm('회원탈퇴하신 아이디입니다. 복구하시겠습니까 ?')){				
					location.href='restore.jsp?u_id='+${param.u_id}+'&u_pass='+${param.u_pass};
				}
			</script>
	</c:if>
</c:if>

<c:if test="${rs.rowCount == 0}">
	<script>
		alert('로그인 실패');
		location.href='login.jsp';
	</script>
</c:if>