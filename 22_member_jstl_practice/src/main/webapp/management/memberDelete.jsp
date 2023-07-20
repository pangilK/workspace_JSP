<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- memberDelete.jsp -->
<!-- 삭제할 회원 번호를 넘겨 받아 u_join column의 값을 N으로 수정 -->
<s:transaction dataSource="java/MySqlDB">
	<s:update var="rs">
		DELETE FROM digital_member WHERE u_num = ${param.u_num};
	</s:update>
</s:transaction>
<c:if test="${rs == 1}">
	<script>
		alert('처리 완료');
		location.href='member.jsp';
	</script>
</c:if>

<%-- <script>
	if(confirm('정말로 삭제하시겠습니까?')){
		<% request.setAttribute("del","d"); %>
	}else {
		alert('잘 생각하셨수');
		history.go(-1);
	}
</script>
<c:set var="del" value=<% request.getAttribute("del"); %>/>
<c:if test="${del eq 'd'}">
	<h1>됬노..?</h1>
</c:if> --%>










