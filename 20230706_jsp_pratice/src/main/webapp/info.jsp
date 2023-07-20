<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- info.jsp -->
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<script>
	window.onload = () => {
		document.querySelector('.id').innerText = '<%= loginMember.getId() %>';
		document.querySelector('.name').innerText = '<%= loginMember.getName() %>';
		document.querySelector('.pass').innerText = '<%= loginMember.getPass() %>';
		document.querySelector('.addr').innerText = '<%= loginMember.getAddr() %>';
		document.querySelector('.phone').innerText = '<%= loginMember.getPhone() %>';
		document.querySelector('.age').innerText = '<%= loginMember.getAge() %>';
		<% if(loginMember.getGender().equals("남성")) { %>
			  document.querySelector('.mail').checked = true;
		<% } else { %>
			  document.querySelector('.femail').checked = true;
		<% } %>
	}
</script>
<section>
 	<table>
 		<tr>
 			<td colspan="2"><h1>회원가입</h1></td>
 		</tr>
 		<tr>
 			<td >아이디</td>
 			<td class="id">
 			
			</td>
 		</tr>
 		<tr>
 			<td>비밀번호</td>
 			<td class="pass">
 			
			</td>
 		</tr>
 		<tr>
 			<td>이름</td>
 			<td class="name">
 			
 			</td>
 		</tr>
 		<tr>
 			<td>주소</td>
 			<td class="addr">
 			
 			</td>
 		</tr>
 		<tr>
 			<td>전화번호</td>
 			<td class="phone">
 			
 			</td>
 		</tr>
 		<tr>
 			<td>성별</td>
 			<td>
 				<label>
 					<input type="radio" class="mail" disabled/> 남성
 				</label>
 				<label>
 					<input type="radio" class="femail" disabled/> 여성
 				</label>
 			</td>
 		</tr>
 		<tr>
 			<td>나이</td>
 			<td class="age">
 			
 			</td>
 		</tr>
 		<tr>
 			<td colspan="2">
 				<button onclick="location.href='index.jsp';">메인으로</button> 
				 <button onclick="withdraw();">회원탈퇴</button> 
 			</td>
 		</tr>
 	</table>	
</section>
<script>
	function withdraw(){
		let result = confirm("정말로 탈퇴 하시겠습니까?");	
		if(result){
			location.href="withdraw.jsp";	
		}
	}
</script>











 	
 	
 	
 	
 	
 	