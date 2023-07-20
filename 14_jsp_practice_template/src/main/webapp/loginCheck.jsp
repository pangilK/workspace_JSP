<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- loginCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="dto" class="dto.LoginDTO"/>
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="memberList" type="java.util.List<vo.MemberVO>" class="java.util.ArrayList" scope="application"/>

<%
	for(MemberVO m : memberList){
		if(m.getId().equals(dto.getId()) && m.getPass().equals(dto.getPass())){
			session.setAttribute("loginMember",m);
			
			if(dto.isRememberMe()){
				
				/* Cookie cookie = new Cookie("rememberMe",m.getId());
				cookie.setMaxAge(60*60*24*10);
				response.addCookie(cookie); */
				
				response.addHeader("Set-Cookie", "rememberMe="+m.getId()+"; Max-Age=864000;");
			}
			
			out.println("<script>");
			out.println("alert('로그인 성공');");
			out.println("location.href='index.jsp';");
			out.println("</script>");
			return;
		}
	}
%>
<script>
	alert('로그인 실패');
	history.back();
</script>






