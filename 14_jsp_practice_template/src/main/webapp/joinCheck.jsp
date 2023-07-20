<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- joinCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="joinMember" class="vo.MemberVO"/>
<jsp:setProperty name="joinMember" property="*" />
<!-- List<MemberVO> memberList = new ArrayList();  -->
<jsp:useBean id="memberList" type="java.util.List<vo.MemberVO>" class="java.util.ArrayList" scope="application"/>

<%
	if(memberList.contains(joinMember)){
		// 중복 아이디
		out.println("<script>");
		out.println("alert('이미 사용중인 아이디입니다.');");
		out.println("history.back()");
		out.println("</script>");
	} else {
		memberList.add(joinMember);
		out.println("<script>");
		out.println("alert('회원가입 성공');");
		out.println("location.href='index.jsp?page=login';");
		out.println("</script>");
	}

	System.out.println("============================");
	for(MemberVO m : memberList){
		System.out.println(m);	
	}
	System.out.println("============================");
%>







