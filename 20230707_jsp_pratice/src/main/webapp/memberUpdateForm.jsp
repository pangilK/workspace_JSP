<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<%
	String mNum = request.getParameter("num");

	if(mNum == null || mNum.equals("1")){
		out.println("<script>alert('안됨');history.back();</script>");
		return;
	}	
	int num = Integer.parseInt(mNum);
	
	PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM test_member where num = ?");
	pstmt.setInt(1,Integer.parseInt(mNum));
	
	ResultSet rs = pstmt.executeQuery();
	
	String id = "";
	String pass = "";
	String name = "";
	String addr = "";
	String phone = "";
	String gender = "";
	int age = 0;
	if(rs.next()){
		id = rs.getString("id");
		pass = rs.getString("pass");
		name = rs.getString("name");
		addr = rs.getString("addr");
		phone = rs.getString("phone");
		gender = rs.getString("gender");
		age = rs.getInt("age");
	}
%>
<script>
	window.onload = () => {
		<% if(gender.equals("남성")) { %>
		  	  document.querySelector('.mail').checked = true;			  
		<% } else { %>
			  document.querySelector('.femail').checked = true;
		<% } %>
		};
</script>
<form action="memberUpdate.jsp" method="post">
	<table>
		<input type="hidden" name="num" value="<%=num%>"/>
		<tr>
			<th colspan="2">회원정보수정</th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input name="id" type="text" value="<%= id%>" />
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input name="pass" type="password" value="<%= pass%>" />
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input name="name" type="text" value="<%= name%>" />
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>
				<input name="addr" type="text" value="<%= addr%>" />
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input name="phone" type="text" value="<%= phone%>" />
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
 					<input name="gender" type="radio" class="mail"/> 남성
 				</label>
 				<label>
 					<input name="gender" type="radio" class="femail"/> 여성
 				</label>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input name="age" type="number" value="<%= age%>" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button>수정완료</button>
			</td>
		</tr>
	</table>
</form>