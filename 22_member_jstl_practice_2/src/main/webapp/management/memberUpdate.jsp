<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<jsp:include page="/common/header.jsp" />
<section class="wrap">
<!-- memberUpdate.jsp -->
<!-- 수정할 회원 정보를 검색해 updateMember 를 key값으로 저장 하여 출력 -->

<!-- 접근 권한이 존재하는 사용자 인지 확인 -->
<%@ include file="checkAdmin.jsp" %>

<s:query var="rs" dataSource="java/MySqlDB">
	SELECT * FROM digital_member WHERE u_num = ? 
	<s:param>${param.u_num}</s:param>
</s:query>
<c:if test="${rs.rowCount > 0}">
	<jsp:useBean id="updateMember" class="vo.MemberVO" />
	<c:forEach var="column" items="${rs.columnNames}">
		<c:set target="${updateMember}" property="${column}" value="${rs.rows[0][column]}"/>
	</c:forEach>
</c:if>
<form action="<c:url value='/management/memberSubmit.jsp'/>" method="POST">
	<table>
		<tr>
			<td colspan=2><h3>회원정보 수정</h3></td>
		</tr>
		<tr>
			<td>회원번호</td>
			<td>
				<input type="text" name="u_num" value="${updateMember.u_num}" readonly />
			</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="u_id" value="${updateMember.u_id}" readonly />
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="u_pass" value="${updateMember.u_pass}" required />
				<button type="button" onclick="changePass(this);">비밀번호 보기</button>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="u_age" value="${updateMember.u_age}" required />
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
					<input <c:out value="${updateMember.u_gender eq 'male' ? 'checked' : ''}" />
					type="radio" name="u_gender" value="male" /> 남성
				</label>
					<input <c:out value="${updateMember.u_gender eq 'female' ? 'checked' : ''}" />
					type="radio" id="female" name="u_gender" value="female"/>
				<label for="female"> 여성 </label>
			</td>
		</tr>
		<tr>
			<td colspan=2>
				<input type="submit" value="수정완료"/>
			</td>
		</tr>
	</table>
</form>
<script>
	function changePass(btn){
		/*  
			button 의 부모요소 = td
			td의 첫번째 자식요소 = input type=password
		*/
		/* let el = btn.parentNode.firstChild; */
		let el = btn.parentNode.firstElementChild;
		console.log(el);
		let attr = el.getAttribute("type");
		if(attr == 'password'){
			el.setAttribute('type','text');
			btn.innerText = '비밀번호 감추기';
		}else{
			el.setAttribute('type','password');
			btn.innerHTML = '비밀번호 보기';
		}
	}
</script>
</section>
<jsp:include page="/common/footer.jsp" />






















