<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- joinCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="joinMember" class="vo.MemberVO" />
<jsp:setProperty name="joinMember" property="*"/>
<jsp:useBean id="memberList" class="java.util.ArrayList" type="java.util.List<vo.MemberVO>" scope="application"/>

<%
	if(memberList.contains(joinMember)){
		out.println("<script>");
		out.println("alert('회원가입 실패 이미 사용중인 아이디이거나 사용 할 수 없는 아이디입니다.')");
		out.println("location.href='index.jsp?page=join';");
		out.println("</script>");
	}else{
		memberList.add(joinMember);
		out.println("<script>");
		out.println("alert('회원가입 완료')");
		out.println("location.href='index.jsp?page=login';");
		out.println("</script>");
	}

	for(MemberVO m : memberList){
		System.out.println(m);
	}
%>





