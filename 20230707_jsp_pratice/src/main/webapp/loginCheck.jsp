<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connection.jsp" %>
<jsp:useBean id="loginAccount" type="java.util.List<vo.MemberVO>" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String login = request.getParameter("login"); 
	Statement stmt = null;
	boolean loginCheck = false;
	
	stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT * FROM test_member");
	
	while(rs.next()){
		if(id.equals(rs.getString("id")) && pass.equals(rs.getString("pass"))){
			
			for(MemberVO m : loginAccount){
				if(m.getId().equals(id) && m.getPass().equals(pass)){
					out.println("<script>");
					out.println("alert('이미 로그인 중 인 회원입니다.');");
					out.println("location.href='index.jsp?page=login';");
					out.println("</script>");
					return;
				}
			}
			
			loginMember.setId(id);
			loginMember.setPass(pass);
			loginMember.setName(rs.getString("name"));
			loginMember.setAddr(rs.getString("addr"));
			loginMember.setPhone(rs.getString("phone"));
			loginMember.setGender(rs.getString("gender"));
			loginMember.setAge(rs.getInt("age"));
			
			loginCheck = true;
			break;
		}
	}
	
	if(loginCheck){
		// loginAccount.add(loginMember);
		if(login != null){
			Cookie cookie = new Cookie("rememberMe",id);
			cookie.setMaxAge(60*60*24*10);
			response.addCookie(cookie);
		}
		out.println("<script>");
		out.println("alert('로그인 완료');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
	}else {
		out.println("<script>");
		out.println("alert('아이디나 비밀번호를 다시 한번 확인해주세요.');");
		out.println("location.href='index.jsp?page=login';");
		out.println("</script>");
	}
		
	
%>