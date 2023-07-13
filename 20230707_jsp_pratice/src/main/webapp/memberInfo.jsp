<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	String name = "";
	String addr = "";
	if(rs.next()){
		id = rs.getString("id");
		name = rs.getString("name");
		addr = rs.getString("addr");
	}
%>
<table>
	<tr>
		<th><%= num %> 번의 회원정보</th>
	</tr>
	<tr>
		<td>아이디 : <%= id %></td>
	</tr>
	<tr>
		<td>이름 : <%= name %></td>
	</tr>
	<tr>
		<td>주소 : <%= addr %></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:location.href='index.jsp?page=memberUpdateForm&num=<%=num%>'">수정</a> | 
			<a href="#" id="delete">삭제</a>
		</td>
	</tr>
</table>
<script>
	window.onload = () => {
		document.querySelector("#delete").onclick = () => {
			let result = confirm("정말로 삭제하시겠습니까..?");
			if(result){
				location.href="delete.jsp?num=<%=num%>";
			}
		};
	}
</script>