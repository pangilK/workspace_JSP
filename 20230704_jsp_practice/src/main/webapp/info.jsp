<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberVO m = (MemberVO) session.getAttribute("loginMember");
	if(m == null){
		out.println("<script>");
		out.println("alert('잘못된 접근입니다.');");
		out.println("location.href='https://naver.com'");
		out.println("</script>");		
	} else {
		String sexsual = m.getGender();
%>
	<script>
		window.onload = () => {
			document.querySelector('.id').innerText = '<%= m.getId() %>';
			document.querySelector('.name').innerText = '<%= m.getName() %>';
			document.querySelector('.pass').innerText = '<%= m.getPass() %>';
			document.querySelector('.addr').innerText = '<%= m.getAddr() %>';
			document.querySelector('.phone').innerText = '<%= m.getPhone() %>';
			document.querySelector('.age').innerText = '<%= m.getAge() %>';
			<% if(sexsual.equals("남성")) { %>
				  document.querySelector('.mail').checked = true;
			<% } else { %>
				  document.querySelector('.femail').checked = true;
			<% } %>
		}
	</script>
<%  } %>
<jsp:include page="common/header.jsp" />
<!-- info.jsp -->
<section>
 	<table>
 		<tr>
 			<td colspan="2"><h1>내 정보</h1></td>
 		</tr>
 		<tr>
 			<td>아이디</td>
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
 					<input type="radio" disabled class="mail"/> 남성
 				</label>
 				<label>
 					<input type="radio" disabled class="femail"/> 여성
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
 			</td>
 		</tr>
 	</table>	
</section>
<jsp:include page="common/footer.jsp" />











 	
 	
 	
 	
 	
 	