<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="request_test/requestTest.jsp">request method 확인</a>
	<hr/>
	<!-- 
		pageContext < 	  request 	 < 	  session	 < 	application
		JSP page 	   요청에 대한 응답		 브라우저 종료       서버 종료
	 -->
	<%
		ServletRequest req = pageContext.getRequest();
		HttpSession ses = pageContext.getSession();
		ServletContext app = pageContext.getServletContext();
		
		// requset
		ses = request.getSession();
		app = request.getServletContext();
		
		// session
		app = session.getServletContext();
	%>
	<a href="attrForm.jsp">속성-영역 객체 테스트</a>
	<hr />
	<h3>application id : <%=application.getAttribute("id")%></h3>
	<h3>pageContext id : <%=pageContext.getAttribute("pageID")%></h3>
	<h3>request email : <%=request.getAttribute("reqEmail")%></h3>
	<h3>session email : <%=session.getAttribute("email")%></h3>
</body>
</html>