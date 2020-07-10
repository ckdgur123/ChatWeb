<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="document.f.username.focus();">


	<form method="post" action="<c:url value="/login" />">
	
		<p>ID : <input type="text" name="username"></p>
		<p>PWD : <input type="password" name="password"></p>
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    
	    <input type="submit" value="로그인">
	</form>
</body>
</html>