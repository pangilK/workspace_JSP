<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");

   String appID = (String) application.getAttribute("id");
   String appPW = (String) application.getAttribute("pw");
  
   if(appID.equals(id) && appPW.equals(pw)){
	   String appName = (String) application.getAttribute("name");
	   session.setAttribute("userName",appName);
	   response.sendRedirect(request.getContextPath());
   }else{
	   String message = "로그인 정보가 일치하지 않습니다.";
	   request.setAttribute("message",message);
	   request.getRequestDispatcher("login.jsp").forward(request,response);
   }
%>