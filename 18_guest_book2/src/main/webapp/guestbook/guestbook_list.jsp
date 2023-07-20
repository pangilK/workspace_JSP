<%@page import="org.apache.tomcat.jakartaee.bcel.classfile.StackMapType"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>방명록 메시지 목록</title>
</head>
<style>
	
</style>
<body>
<!-- 방명록 작성 전달을 위한 form tag 완성 -->
<form action="<%=path%>/guestbook/guestbook_write.jsp" method="post">
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
			<td><input type="text" name="guestName" style="width:100%;"/></td>
		<tr>
			<td>암호</td>
			<td><input type="password" name="password" style="width:100%;"/></td>
		</tr>
		<tr>
			<td>메시지</td>
			<td><textarea cols="35" name="message" rows="3"></textarea></td>
		</tr>
	</table>
</form>
<hr>
<%@ page import="java.sql.*" %>
<!-- 방명록 리스트 정보 출력 -->
<%
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/digital_jsp",
		"digital",
		"12345"
	);
	
	// 요청이 들어온 페이지 첫번째 페이지 그 다음은 1씩 증가
	int currentPage = 1; 
	// 한 페이지에 보여줄 게시물 개수
	int pageCount = 5;
	// 테이블에 pageCount 만큼 검색할 시작 인덱스 번호
	int startRow = 0;
	
	String paramPage = request.getParameter("page");
	if(paramPage != null){
		currentPage = Integer.parseInt(paramPage);	
	}
	out.println("현재 요청 페이지 : " + currentPage);
	
	// 1 page : (1-1) * 5 = 0;
	// 2 page : (2-1) * 5 = 5;
	startRow = (currentPage - 1 )*pageCount;
	PreparedStatement pstmt = conn.prepareStatement(
		"SELECT * FROM test_guestbook ORDER BY id DESC limit ?,?"
	);
	pstmt.setInt(1,startRow);
	pstmt.setInt(2,pageCount);	
	ResultSet rs = pstmt.executeQuery();
	// 글번호
	int id = 0;
	String guestName = null;
	String message = null;
%>
<h1>방명록 리스트</h1>
<table border="1" cellspacing="0" cellpadding="0">
<% 
	while(rs.next()){
		id = rs.getInt("id");
		guestName = rs.getString("guestName");
		message = rs.getString("message");
%>
	<tr>
		<td>
			메세지 번호 : <%=id%> <br/>
			손님 이름 : <%=guestName%> <br/>
			메세지 : <%=message %> <br/>
			<a href="<%=path%>/guestbook/guestbook_confirm.jsp?id=<%=id%>">[삭제]</a>
		</td>
	</tr>
<%}%>
<%if(guestName == null){ %>
<tr>
	<td><h2>등록된 메세지가 없습니다.</h2></td>
</tr>
<%} %>
</table>
<!-- 방명록 리스트 정보 출력 end -->
<%
	if(rs != null){
		rs.close();
	}

	if(pstmt != null){
		pstmt.close();
	}
	
	if(conn != null){
		conn.close();
	}
%>


<!-- 방명록 정보에 따른 paging block 화면 출력 작성 -->
<%
	Context context = new InitialContext();
	DataSource ds = (DataSource)context.lookup("java:comp/env/java/MySqlDB");
	conn = ds.getConnection();
	// test_guestbook table 에 저장된 전체 행의 개수
	String sql = "SELECT count(*) FROM test_guestbook";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	int totalCount = 0;
	if(rs.next()){
		totalCount = rs.getInt(1);
	}
	
	// 이동할수 있는 최대 페이지 번호
	// 130 : 130 / 10 = 13page
	// 129 : 129 / 10 = 12.9 == 12 - 나머지 9개의 게시물을 보여줄 페이지가 없음
	// 129 : 129 / 10 = 12.9 == 12 + 1 = 13
	// 130 : 130 / 10 = 13 + 1 == 14page
	// 130 : (130-1) / 10 = 12 + 1 == 13page
	// 131 : (131-1) / 10 = 13 + 1 == 14page
	int maxPage = (totalCount-1) / pageCount + 1; 
	
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	// 현재 요청 페이지에서 보여줄 시작 페이지 번호
	int startPage = 0;
	// 현재 요청 페이지에서 보여줄 마지막 페이지 번호
	int endPage = 0;
	// 한번에 보여줄 페이지 번호 개수
	int displayPageNum = 5;
	
	//[1][2][3][4][5]  1~5 페이지는 동일한 페이지 번호 출력
	//[6][7][8][9][10] 6~10 페이지는 동일한 번호 출력
	// 시작페이지 번호
	// 1page : (1-1) / 5 * 5 + 1 == 1;
	// 5page : (5-1) 4 / 5 == 0.8 == 0 * 5 == 0 + 1;
	// 6page : (6-1) 5 / 5 == 1 == 1 * 5 == 5 + 1; == 6
	// 10page : (10-1) 9 / 5 == 1.8 == 1 * 5 == 5 + 1; == 6
	// ...
	startPage = (currentPage - 1) / displayPageNum * displayPageNum + 1;
	// 출력된 마지막 페이지 번호
	endPage = startPage + (displayPageNum - 1);
	System.out.println("maxPage : " +maxPage);
	System.out.println("endPage : " +endPage);
	// endPage가 maxPage를 벗어나면 endPage를 maxPage로 변경
	if(endPage > maxPage){
		endPage = maxPage;
	}
	
	if(startPage != 1){
%>
	<a href="<%=path%>/guestbook/guestbook_list.jsp?page=1">[처음]</a>
	<a href="<%=path%>/guestbook/guestbook_list.jsp?page=<%=startPage-1%>">[이전]</a>
<% 		
	}
	// 페이지 번호 출력
	for(int i = startPage; i <= endPage; i++){
%>
	<a href="<%=path %>/guestbook/guestbook_list.jsp?page=<%=i%>">[<%=i%>]</a>
<%  } 

	if(endPage < maxPage){
%>		
	<a href="<%=path%>/guestbook/guestbook_list.jsp?page=<%=endPage+1%>">[다음]</a>
	<a href="<%=path%>/guestbook/guestbook_list.jsp?page=<%=maxPage%>">[끝]</a>
<%	} %>
<!-- 방명록 정보에 따른 paging block 화면 출력 end-->
</body>
</html>