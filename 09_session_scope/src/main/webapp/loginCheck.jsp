<%@page import="vo.MemberVO"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- loginCheck.jsp -->
<%
	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	
	List<MemberVO> memberList = (List<MemberVO>) application.getAttribute("memberList");
	if(memberList == null){
		memberList = new ArrayList<>();
		application.setAttribute("memberList", memberList);
	}
	
	MemberVO member = null;
	
	if(uid != null && upw != null){	
		for(MemberVO m : memberList){
			if(m.getUid().equals(uid) && m.getUpw().equals(upw)){
				member = m;
				break;
			}
		}
	}
	
	if(member == null){
		// 일치하는 사용자가 존재하지 않음
		request.setAttribute("message","로그인 정보가 일치하지 않습니다.");
		request.getRequestDispatcher("login.jsp").forward(request,response);
	}else{
		// 일치하는 사용자 존재
		session.setAttribute("loginMember", member);
		String path = request.getContextPath();
		System.out.println("context : " + path);
		response.sendRedirect(path);
	}
%>