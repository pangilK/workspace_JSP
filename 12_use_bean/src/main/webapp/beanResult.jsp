<%@page import="beans.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beanResult.jsp</title>
</head>
<body>
	<%
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");
		String email = request.getParameter("email");
		int age = Integer.parseInt(request.getParameter("age"));
		
		MemberVO m = new MemberVO(name,addr,email,age);
		
		m.setName(name);
		m.setAddr(addr);
		m.setEmail(email);
		m.setAge(age);
		
		pageContext.setAttribute("a",m);
		System.out.println(m);
	%>
	<%= m.toString() %> <br/>
	
	<jsp:useBean id="a" class="beans.MemberVO" /> 
	<jsp:getProperty property="name" name="a"/>  <br/>
	<jsp:getProperty property="addr" name="a"/>  <br/>
	<jsp:getProperty property="email" name="a"/> <br/>
	<jsp:getProperty property="age" name="a"/>   <br/>
	
	<!-- useBean 프로퍼티 활용 -->
	<jsp:useBean id="m1" class="beans.MemberVO" />
	<jsp:setProperty property="*" name="m1"/>
	<%-- 	
		<jsp:setProperty name="m1" property="name"/>
		<jsp:setProperty name="m1" property="addr"/>
		<jsp:setProperty name="m1" property="email"/>
	--%>
	<hr/>
	name  : <jsp:getProperty name="m1" property="name"/>  <br/>
    addr  : <jsp:getProperty name="m1" property="addr"/>  <br/>
	email : <jsp:getProperty name="m1" property="email"/> <br/>
	age   : <jsp:getProperty name="m1" property="age"/>   <br/>
</body>
</html>