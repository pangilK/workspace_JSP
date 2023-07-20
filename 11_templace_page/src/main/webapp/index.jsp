<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String selectPage = request.getParameter("page");
	
	if(selectPage == null){
		selectPage = "default";
	}
	
	// default
	selectPage = selectPage + ".jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;
		color:pink;	
	}

	table{
		border-radius:10px;
		width:900px;
		margin:auto;
		text-align:center;
		border : 1px solid black;
		background : linear-gradient(skyblue,deeppink);
	
	}
	
	table tr td:first-child{
		border-right:1px solid grey;
	}
</style>
</head>
<body>
	<table>
		<tr>
			<th colspan="2" height="150">
				<jsp:include page="header.jsp"/>
			</th>
		</tr>
		<tr>
			<td>
				<jsp:include page="aside.jsp"/>
			</td>
			<td width="790">
				<%-- <%@ include file="<%= selectPag %>" %> --%>
				<jsp:include page="<%=selectPage %>"/>
			</td>
		</tr>
		<tr>
			<th colspan="2" height="150">
				<jsp:include page="footer.jsp"/>
			</th>
		</tr>
	</table>
</body>
</html>