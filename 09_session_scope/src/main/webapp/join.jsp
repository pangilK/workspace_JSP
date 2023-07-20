<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- join.jsp -->
<%@ include file="common/header.jsp" %>
<form action="joinCheck.jsp" method="post">
	<table>
		<tr>
			<th colspan="2">
				<h3>JOIN PAGE</h3>
			</th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="uid" required/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="upw" required/>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="uname" required/>
			</td>
		</tr>
		<tr>
			<th colspan="2"><button>회원가입</button></th>
		</tr>
	</table>
</form>
<%@ include file="common/tail.jsp" %>