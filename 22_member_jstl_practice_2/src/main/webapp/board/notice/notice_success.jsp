<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../../common/header.jsp" />
<section>
	<h1>요청 처리 완료! <br/>
	<c:if test="${!empty param.message}">
		 ${param.message}
	</c:if>
	</h1>
	<br/>
	<a href="notice_list.jsp">공지 메인</a>
</section>
<jsp:include page="../../common/footer.jsp" />