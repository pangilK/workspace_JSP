<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, util.* , vo.*"%>
<!-- memberList.jsp -->
<!-- 관리자 회원목록 확인 -->
<!DOCTYPE html>
<%
	Connection conn = DBCPUtil.getConnection();
	Statement stmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM test_member ORDER BY num";
	// 검색된 회원 목록을 저장할 리스트
	ArrayList<MemberVO> memberList = new ArrayList<>();
	try{
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			MemberVO m = new MemberVO();
			m.setNum(rs.getInt("num"));
			m.setId(rs.getString("id"));
			m.setPass(rs.getString("pass"));
			m.setName(rs.getString("name"));
			m.setAddr(rs.getString("addr"));
			m.setPhone(rs.getString("phone"));
			m.setGender(rs.getString("gender"));
			m.setAge(rs.getInt("age"));
			memberList.add(m);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(rs,stmt,conn);
	}
%>
<table border=1>
	<tr>
		<th colspan="7"><h1>회원목록</h1></th>
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
	if(!memberList.isEmpty()){
		for(MemberVO m : memberList){ %>
			<tr title="<%=m.getName() %>님의 회원정보" onclick="location.href='index.jsp?page=memberInfo&num=<%=m.getNum()%>';">
				<th><%= m.getNum() %></th>
				<th><%= m.getId() %></th>
				<th><%= m.getName() %></th>
				<th><%= m.getAddr() %></th>
				<th><%= m.getPhone() %></th>
				<th><%= m.getGender() %></th>
				<th><%= m.getAge() %></th>
			</tr>
	<% 	} 
	} else { %>
		<tr><th colspan="7">등록된 회원이 없습니다.</th></tr>
<%  } %>
</table>