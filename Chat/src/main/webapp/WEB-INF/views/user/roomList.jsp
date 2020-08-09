<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

    <script type="text/javascript">
		function openCreateRoom(){
				window.open("<c:url value='/user/createRoom' />", "방 만들기", "width=500, height=400");
			}
    </script>	
</head>
<body>
	<div class="container">
		<table class="table table-striped">
			<tr>
				<th>번호</th>
				<th>방 이름</th>
				<th>입장</th>
			</tr>
			
			<c:forEach items="${room}" var="roomList">
				<tr>
	    			<td>${room.roomId}</td>
	    			<td>${room.roomName}</td>
	    			<td><a class="btn btn-info" href=#> 입장 </a></td>
	    		</tr>
			</c:forEach>
		</table>
		<div style="text-align:right;">
			<a class="btn btn-primary" href="javascript:openCreateRoom()">새로 만들기</a>
		</div>
	</div>
</body>
</html>