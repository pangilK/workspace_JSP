<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<jsp:include page="/common/header.jsp"/>
<section class="wrap">

<table border=1>
	<tr>
		<th colspan="4">회원정보</th>
	</tr>
	<tr>
		<th>회원번호</th>
		<th>이름</th>
		<th>회원등록일</th>
		<th>기타</th>
	</tr>
	<!-- 등록된 회원 정보가 있을 시 출력 -->
	<c:choose>
		<c:when test="${!empty memberList}">
			<c:forEach var="member" items="${memberList}">
				<tr>
					<td>
						<!-- 회원번호 -->
						${member.num}
					</td>
					<td>
						<!-- 이름 -->
						${member.name}
					</td>
					<td>
						<!-- 회원등록일 -->
						${member.regdate}
					</td>
					<td>
						<!-- 기타 -->
						<a href="updateInfo.mgc?num=${member.num}">수정</a> |
						<a href="#" onclick="deleteMember('${member.num}')">삭제</a>
					</td>
				</tr>
			</c:forEach>
			<!-- 등록된 회원 목록정보가 존재할 시 페이징 처리 블럭 작성 -->
			<c:if test="${!empty pm}">
				<tr>
					<td colspan="4">
						<c:if test="${pm.prev}">
							<a href="<c:url value='managementPage.mgc'/>?page=${pm.startPage-1}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
							<a href="<c:url value='managementPage.mgc'/>?page=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${pm.next}">
							<a href="<c:url value='managementPage.mgc'/>?page=${pm.endPage + 1}">[다음]</a>
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:when>
	
		<c:otherwise>
			<!-- 등록된 회원 정보가 없을 시 출력 -->
			<tr>
				<th colspan="4">등록된 회원 정보가 없습니다.</th>
			</tr>
		</c:otherwise>
	</c:choose>
	
</table>
</section>
<jsp:include page="/common/footer.jsp" />
<script>
	function deleteMember(memberNumber){
		if(confirm('정말로 삭제하시겠습니까?')){
			location.href = 'delete.mgc?num=' + memberNumber;
		}
	}
</script>









