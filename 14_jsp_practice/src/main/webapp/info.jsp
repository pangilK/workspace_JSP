<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<vo.MemberVO> memberList = (List<vo.MemberVO>) application.getAttribute("memberList");
	String loginMname = (String) session.getAttribute("name");
	String method = request.getMethod().toLowerCase();
	String id = "";
	String pw = "";
	String addr = "";
	String name = "";
	String phone = "";
	int age = 0;
	String gender = "";
	
	if(method.equals("get") && loginMname == null){
		out.println("<script>");
		out.println("alert('잘못된 접근입니다.')");
		out.println("</script>");		
		response.sendRedirect("index.jsp");	
	}
	
	for(vo.MemberVO m : memberList){
		if(loginMname.equals(m.getName())){
			id = m.getId();
			pw = m.getPass();
			addr = m.getAddr();
			name = m.getName();
			phone = m.getPhone();
			age = m.getAge();
			gender = m.getGender();
			break;
		}
	}
	if(gender.equals("남성")){
%>
<script>
	window.onload = () =>{
		document.querySelector("#mail").checked = true;
	}
</script>
<%  } else { %>
<script>
	window.onload = () =>{
		document.querySelector("#femail").checked = true;
	}
</script>
<%  } %>
<jsp:include page="common/header.jsp" />
<!-- info.jsp -->
<section>
 	<table>
 		<tr>
 			<td colspan="2"><h1>회원정보</h1></td>
 		</tr>
 		<tr>
 			<td>아이디</td>
 			<td>
 				<%= id %>
			</td>
 		</tr>
 		<tr>
 			<td>비밀번호</td>
 			<td>
 				<%= pw %>
			</td>
 		</tr>
 		<tr>
 			<td>이름</td>
 			<td>
 				<%= name %>
 			</td>
 		</tr>
 		<tr>
 			<td>주소</td>
 			<td>
 				<%= addr %>
 			</td>
 		</tr>
 		<tr>
 			<td>전화번호</td>
 			<td>
 				<%= phone %>
 			</td>
 		</tr>
 		<tr>
 			<td>성별</td>
 			<td>
 				<label>
 					<input type="radio" disabled id="mail"/> 남성
 				</label>
 				<label>
 					<input type="radio" disabled id="femail"/> 여성
 				</label>
 			</td>
 		</tr>
 		<tr>
 			<td>나이</td>
 			<td>
 				<%= age %>
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












 	
 	
 	
 	
 	
 	