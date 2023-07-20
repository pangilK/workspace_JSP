<%@ page pageEncoding="UTF-8"%>
<%
	String selPage = request.getParameter("page");

	if(selPage == null){
		selPage = "default";
	}
%>
<jsp:include page="common/header.jsp" />
<section>
	<jsp:include page='<%= selPage+".jsp"%>'/>
</section>
<jsp:include page="common/footer.jsp" />








