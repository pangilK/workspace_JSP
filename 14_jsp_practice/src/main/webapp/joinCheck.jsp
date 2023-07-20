<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="joinMember" class="vo.MemberVO"/>
<jsp:setProperty property="*" name="joinMember"/>
<!-- joinCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>
<%
	/* id , pass , name , addr , gender , age */
	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	int age = Integer.parseInt(request.getParameter("age"));
	String method = request.getMethod().toLowerCase();
	boolean isCheck = false;

	
	vo.MemberVO joinM = new vo.MemberVO(id,pw,name,addr,phone,gender,age);
	
	List<vo.MemberVO> memberList = (List<vo.MemberVO>) application.getAttribute("memberList");
	
	
	if(memberList == null){
		if(method.equals("get")){
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.')");
			out.println("</script>");		
			response.sendRedirect("join.jsp");	
		}else{
			memberList = new ArrayList<>();
			application.setAttribute("memberList",memberList);	
		}
	}else{
		for(vo.MemberVO m : memberList){
			if(id.equals(m.getId())){
				isCheck = true;
				break;
			}
		}
	}
	
	
	out.println("<script>");
	if(isCheck){
		out.println("alert('이미 사용중인거나 사용할수 없는 아이디입니다.')");
		out.println("history.go(-1);");
	}else{
		memberList.add(joinM);
		out.println("alert('회원가입 성공')");
		out.println("location.href='login.jsp'");
	}
	out.println("</script>");

%>







