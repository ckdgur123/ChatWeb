<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% response.setStatus(404); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
	alert('서버에 오류가 발생하였습니다. 홈페이지로 이동합니다.');
	location.href = "<c:url value='/' />";
</script>

</body>
</html>