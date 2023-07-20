<%@ page pageEncoding="UTF-8"%>
<!-- logOut.jsp -->
<%
	// session.removeAttribute("loginMember");
	session.invalidate();
	
	// 로그 아웃 시 등록된 자동로그인 쿠키도 삭제
	Cookie cookie = new Cookie("id","");
	cookie.setMaxAge(0);
	cookie.setPath("/");
	response.addCookie(cookie);
%>
<script>
	alert('로그아웃 완료');
	location.href='index.jsp';
</script>






