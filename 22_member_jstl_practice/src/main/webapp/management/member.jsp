<%@page import="util.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<jsp:include page="/common/header.jsp" />
<%@ page import="util.PageMaker" %>
<%
	int selectPage;
	try{
		String selectPageParam = request.getParameter("selectPage");
	    selectPage = (selectPageParam != null) ? Integer.parseInt(selectPageParam) : 1;
	}catch(NumberFormatException e){
		selectPage = 1;
	}
	Criteria cri = new Criteria();
	cri.setPage(selectPage);
	
	PageMaker pageMaker = new PageMaker();
	pageMaker.setDisplayPageNum(5);
	pageMaker.setCri(cri);
%>
<section class="wrap">
<table border=1>
	<tr>
		<th colspan="4">회원정보</th>
	</tr>
	<tr>
		<th>회원번호</th>
		<th>아이디</th>
		<th>회원등록일</th>
		<th>기타</th>
	</tr>
	<!-- 등록된 회원 정보가 있을 시 출력 -->
	<s:query var="r" dataSource="java/MySqlDB">
		SELECT * FROM digital_member where u_id != 'admin' and u_join = 'Y' ORDER BY u_num asc limit ?,5
		<s:param value="<%= (selectPage-1)*5 %>" />
	</s:query>
	<c:choose>
		<c:when test="${r.rowCount > 0}">
			<c:forEach var="m" items='${r.rows}'>	
				<tr>
					<td>${m.u_num}</td>
					<td>${m.u_id}</td>
					<td>${m.u_regdate}</td>
					<td>
						<a href="<c:url value='/management/memberUpdate.jsp'/>?u_num=${m.u_num}">수정</a> |
						<a href="<c:url value='/management/memberDelete.jsp'/>?u_num=${m.u_num}">삭제</a>
					</td>
				</tr>
				
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="4">등록된 회원정보가 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
	<s:query var="rp" dataSource="java/MySqlDB" >
		SELECT * FROM digital_member where u_id != 'admin' and u_join = 'Y' ORDER BY u_num asc
	</s:query>
	<c:set var="pm" value="<%=pageMaker%>"/>
	<c:set target="${pm}" property="totalCount" value="${rp.rowCount}" />
	<tr>
		<td colspan="4">
			<c:if test="${pm.prev}">
				<a href="<c:url value='/management/member.jsp'/>?selectPage=${pm.startPage-1}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
				<a href="<c:url value='/management/member.jsp'/>?selectPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${pm.next}">
				<a href="<c:url value='/management/member.jsp'/>?selectPage=${pm.endPage + 1}">[다음]</a>
			</c:if>
		</td>
	</tr>
	
</table>
</section>
<jsp:include page="/common/footer.jsp" />











