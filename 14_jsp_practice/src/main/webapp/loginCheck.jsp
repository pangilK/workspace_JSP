<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="loginMember" class="vo.MemberVO" scope="session"/>
<!-- loginCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>
<%
	out.println("<script>");
	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String login = request.getParameter("login");
	boolean isCheck = false;
	List<vo.MemberVO> memberList = (List<vo.MemberVO>) application.getAttribute("memberList");
	
	if(memberList == null){
		out.println("alert('로그인 실패')");
		out.println("location.href='index.jsp'");
	} else {
		
		for(vo.MemberVO m : memberList){
			String mId = m.getId();
			String mPw = m.getPass();
			if(id.equals(mId) && pw.equals(mPw)){
				session.setAttribute("name",m.getName());
				isCheck = true;
				break;
			}
		}
		
		if(isCheck){
			if(login != null){
				Cookie cookie = new Cookie("id",id);
				cookie.setMaxAge(60*60*24*30);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			out.println("alert('로그인 성공')");
			out.println("location.href='index.jsp'");
		}else{
			session.removeAttribute("loginMember");
			out.println("alert('로그인 실패')");
			out.println("history.go(-1);");
		}
	}
	out.println("</script>");
%>







