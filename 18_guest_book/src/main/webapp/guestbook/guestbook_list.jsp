<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, util.*"%>
<jsp:useBean id="bookList" type="java.util.List<String[]>" class="java.util.ArrayList" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>방명록 메시지 목록</title>
</head>
<style>
	div{
		border : solid 2px black;
		width : 200px;
		margin-bottom:5px;
	}
</style>
<body>
<!-- 방명록 작성 전달을 위한 form tag 완성 -->
<form action="guestbook_write.jsp" method="post">
	<table>
		<tr>
			<td colspan=3><h1>방명록 작성</h1></td>
		</tr>
		<tr>
			<td colspan=2></td>
			<td rowspan="4"><input type="submit" value="메시지 남기기" style="width:100%;height:100px;margin-left:20px;"/></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" style="width:100%;"/></td>
		<tr>
			<td>암호</td>
			<td><input type="password" name="pw" style="width:100%;"/></td>
		</tr>
		<tr>
			<td>메시지</td>
			<td><textarea cols="35" rows="3" name="message"></textarea></td>
		</tr>
	</table>
</form>
<hr>
<h1>방명록 리스트</h1>
<!-- 방명록 리스트 정보 출력 -->
<%
	Connection conn = DBCPUtil.getConnection();
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT * FROM test_guestbook ORDER BY id desc");
	boolean isCheck = false;
	double maxBoard = 4.0;
	int pageNum;
	try {
	    pageNum = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException e) {
	    pageNum = 1;
	}
	
	while(rs.next()){
		String id = String.valueOf(rs.getInt("id"));
		String[] gbook = { 
				id,rs.getString("guestName"),
				rs.getString("password"),
				rs.getString("message")
		};
		bookList.add(gbook);
		isCheck = true;
	}
	int paging = (int) Math.ceil(bookList.size() / maxBoard);
%>

<%  if(isCheck){ 
		for(int i = (pageNum-1)*(int)maxBoard; i < maxBoard*pageNum ; i++){
			if(i < bookList.size()){				
				String id = bookList.get(i)[0];
				String guestName = bookList.get(i)[1];
				String message = bookList.get(i)[3]; 
%>
			<div>
				<span>메시지 번호 : <%= id %></span> <br/>
				<span>손님 이름 : <%= guestName %></span> <br/>
				<span>메시지 : <%= message %></span> <br/>
				<a href="guestbook_confirm.jsp?id=<%=id%>">[삭제하기]</a>
			</div>
<% 
			} // end if 
		} // end for
	} else { %>
	<p>등록된 메세지가 없습니다.</p>
<%  } %>
<!-- 방명록 정보에 따른 paging block 화면 출력 작성 -->
<script>
	window.onload = () =>{
		const paging = <%= paging %>;
		
		for(let i = 0 ; i < paging ; i++){
			const aTag = document.createElement("a");
			const span = document.createElement("span");
			let pNum = i+1;
			aTag.innerText = `[`+pNum+`]`;
			aTag.href = `guestbook_list.jsp?page=`+pNum;
			
			span.innerText = ` | `;
			document.body.append(aTag);
			if(i < paging-1){
				document.body.append(span);
			}
		}
	}
</script>
<!-- 방명록 정보에 따른 paging block 화면 출력 end-->
</body>
</html>