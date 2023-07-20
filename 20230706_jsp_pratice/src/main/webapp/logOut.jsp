<%@ page pageEncoding="UTF-8"%>
<!-- logOut.jsp -->
<%
	// session 무효화
	session.invalidate();

	Cookie cookie = new Cookie("rememberMe","");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<script>
	alert('처리완료');
	location.href='index.jsp';
</script>






