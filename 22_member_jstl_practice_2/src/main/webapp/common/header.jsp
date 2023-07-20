<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Member</title>
<c:url var="context" value="/"/>
<link href="${context}/css/header.css" rel="stylesheet" type="text/css" />
<link href="${context}/css/footer.css" rel="stylesheet" type="text/css" />
<link href="${context}/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div>
	request : ${request.cookies} <br/> <!-- == pageContext.findAttribute("request").getCookies() --> 
	cookie : ${pageContext.request.cookies} <br/> 
	<br/> session id : ${pageContext.session.id} 
	<br/>
	<c:set var="cookies" value="${pageContext.request.cookies}"/>
	<c:if test="${!empty cookies}">
		<c:forEach var="c" items="${cookies}">
			<c:if test="${c.name eq 'u_id'}">
				${c.name} - ${c.value} <br/>
			</c:if>
		</c:forEach>
	</c:if>
	<br/> cookie [] 정보 : ${cookie}
	<br/> cookie [] name값이 u_id 정보 : ${cookie.u_id}
	<br/> cookie [] name값이 u_id 정보 : ${cookie['u_id']}
	<br/> cookie [] name값이 u_id name 정보 : ${cookie.u_id.name}
	<br/> cookie [] name값이 u_id value 정보 : ${cookie['u_id']['value']}
	<!-- 
		name이 u_id인 cookie 정보가 존재하고  로그인된 회원 정보가 존재하지 않을 때
		자동로그인 요청 처리
	 -->
	 ${!empty cookie.u_id} <br/>
	<c:if test="${!empty cookie.u_id and empty sessionScope.member}">
		<h1>Cookie 존재</h1>
		<s:query var="rs" dataSource="java/MySqlDB">
			SELECT * FROM digital_member WHERE u_id = ?
			<s:param>${cookie.u_id.value}</s:param>
		</s:query>
		<c:if test="${rs.rowCount > 0}">
			<h1>검색된 사용자 정보 존재</h1>
			<jsp:useBean id="member" class="vo.MemberVO" scope="session"/>
			<%-- <c:set target="${member}" property="u_num" value="${rs.rows[0]['u_num']}"/> --%>
			<%-- ${rs.columnNames} - SELECT 검색된 테이블의 속성 이름을 저장하는 배열 --%>
			<c:forEach var="columnName" items="${rs.columnNames}">
				<%-- ${columnName} - <br/> --%>
				<c:set target="${member}" property="${columnName}" value="${rs.rows[0][columnName]}"/>
			</c:forEach>
		</c:if>
		${member} <Br/>
	</c:if>      
	</div>
	<header>
		<div>
			<ul>
				<li><a href="<c:url value='/index.jsp'/>">home</a></li>
				<c:choose>
					<c:when test="${!empty sessionScope.member}">
						<li><a href="<c:url value='/member/info.jsp'/>">${member.u_id}</a>님 방가</li>
						<c:if test="${member.u_id eq 'admin'}">
							<li><a href="<c:url value='/management/member.jsp'/>">회원관리</a></li>
						</c:if>
						<li><a href="<c:url value='/member/logOut.jsp'/>">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="<c:url value='/member/login.jsp'/>">로그인</a></li>
						<li><a href="<c:url value='/member/join.jsp'/>">회원가입</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div>
			<ul>
				<li><a href="<c:url value='/board/notice/notice_list.jsp'/>">공지사항</a></li>
				<li><a href="<c:url value='/board/qna/qna_list.jsp'/>">질문과답변</a></li>
			</ul>
		</div>
	</header>
	
	
	
	
	