<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- header.jsp -->
<%@ include file="../connection.jsp" %>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<% 
   Cookie[] cookies = request.getCookies();
   if(loginMember.getId() == null && cookies != null){
	   for(Cookie c : cookies){
		   if(c.getName().equals("rememberMe")){
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM test_member WHERE id = ?");
				pstmt.setString(1,c.getValue());
				ResultSet rs = pstmt.executeQuery();
				
				if(rs.next()){
					loginMember.setId(rs.getString("id"));
					loginMember.setPass(rs.getString("pass"));
					loginMember.setAddr(rs.getString("addr"));
					loginMember.setName(rs.getString("name"));
					loginMember.setPhone(rs.getString("phone"));
					loginMember.setGender(rs.getString("gender"));
					loginMember.setAge(rs.getInt("age"));
		   		}
				
	   		}
			break;
   		} // end for
   }
%>
<ul>
	 	<li><a href="index.jsp">홈</a></li>
	 	<% if(loginMember.getId() != null){
	 			if(loginMember.getId().equals("admin")) { %>
		 			<li><a href="index.jsp?page=info"><%=loginMember.getName() %></a>님 방가방가</li>
		 			<li><a href="index.jsp?page=memberList">회원관리</a></li>
	 		 <% } else { %>
			 		<li><a href="index.jsp?page=info"><%=loginMember.getName() %></a>님 반갑습니다.</li>
		 	 <% } %>
			 		<li><a href="logOut.jsp">로그아웃</a></li>
	 	<% } else { %>
			<li><a href="index.jsp?page=login">로그인</a></li>
		 	<li><a href="index.jsp?page=join">회원가입</a></li>
	 	<% } %>
</ul>

 
 
 
 
 
 
 
 
 