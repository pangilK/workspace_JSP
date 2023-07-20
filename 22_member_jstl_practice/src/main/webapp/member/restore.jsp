<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<s:update var="rs" dataSource="java/MySqlDB">
	UPDATE digital_member SET u_join = 'Y' where u_id = ?
	<s:param>${param.u_id}</s:param>
</s:update>
<script>
	location.href='loginCheck.jsp?u_id='+${param.u_id}+'&u_pass='+${param.u_pass};
</script>