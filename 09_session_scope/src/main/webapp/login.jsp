<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- login.jsp -->
<%@ include file="common/header.jsp" %>
<form action="loginCheck.jsp" method="post">
	<table>
		<tr>
			<th colspan="2">
				<h3>LOGIN PAGE</h3>
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
		<tr><th colspan="2"><button>로그인</button></th></tr>
	</table>
</form>
<%@ include file="common/tail.jsp" %>