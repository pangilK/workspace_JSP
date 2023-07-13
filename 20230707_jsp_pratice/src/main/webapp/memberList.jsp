<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<!DOCTYPE html>
<%
	Statement stmt = conn.createStatement();
	String sql = "SELECT * FROM test_member ORDER BY num";
	ResultSet rs = stmt.executeQuery(sql);
%>
<table border = "1">
	<tr>
		<th colspan="7">회원목록</th>
	</tr>
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>성별</th>
		<th>나이</th>
	</tr>
	<%
		while(rs.next()){
			int num = rs.getInt("num");
			String id = rs.getString("id");
			String name = rs.getString("name");
			String addr = rs.getString("addr");
			String phone = rs.getString("phone");
			String gender = rs.getString("gender");
			int age = rs.getInt("age");
	%>
	<tr onclick="location.href='index.jsp?page=memberInfo&num=<%=num%>';" class="sel">
		<td><%= num%></td>
		<td><%= id%></td>
		<td><%= name%></td>
		<td><%= addr%></td>
		<td><%= phone%></td>
		<td><%= gender%></td>
		<td><%= age%></td>
	</tr>
	<%  
		} 

		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(conn != null) conn.close();
	%>
</table>