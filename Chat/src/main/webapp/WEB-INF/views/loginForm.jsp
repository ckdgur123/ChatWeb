<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 부트스트랩 -->
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
	
	<!-- 무료아이콘 -->
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<style>
		label { font-size:14px;}
	</style>
	
	<script>
		
	</script>
</head>
<body onload="document.f.userId.focus();">
	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

		<a class="navbar-brand" href="<c:url value="/" />"> <i class="fa fa-heart" aria-hidden="true"></i> 채팅
		</a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="<c:url value="/" />">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/user/matching/" />">Matching</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/user/board/" />">Board</a></li>
			</ul>

			<div style="text-align:right;width:10%;">
				<ul class="navbar-nav mr-auto" >
					<li class="nav-item dropdown" >
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"aria-expanded="false" >
							
							<!--  로그인 하지 않으면 Guest 로 보이고, 로그인하면 닉네임이 보이도록 설정-->
							<sec:authorize access="isAnonymous()">
								Guest
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<span style="color:white;">${nickname} </span>님
							</sec:authorize>
						</a>
						
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<sec:authorize access="isAnonymous()">
								<a class="dropdown-item" href="<c:url value="/loginForm" />">로그인</a>
								<a class="dropdown-item" href="<c:url value="/signupForm" />">회원가입</a>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<a class="dropdown-item" href="<c:url value="/updateUser" />">회원정보수정</a>
								<a class="dropdown-item" href="#" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
								<form id="logout-form" action='<c:url value='/logout'/>' method="POST">
							   		<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
								</form>
								
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Something else here</a>
							</sec:authorize>
							

						</div></li>
				</ul>
			</div>

		</div>
	</nav>





		<div class="row text-center" style="width: 100%">
		<div style="width: 30%; float: none; margin: 0 auto;">
			<div style="height:80%;"></div>
			
			<form method="post" action="<c:url value="/login" />" name=f>
				<div class="form-group">
					<label for="userId">아이디</label>
					<input type="text" class="form-control" name="userId">
				</div>
				<div class="form-group">
					<label for="password">패스워드</label>
					<input type="password" class="form-control" name="password">
				</div>
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" value="로그인" class="btn btn-success">
			</form>
			
			<div style="height:10%;"></div>
			
			<!-- 로그인에 실패하면 세션에 저장된 에러 메시지를 출력한다. -->
			<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
				
				<p style="color:red; font-weight:bold;"> login Failed! ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message }</p>
				<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
			</c:if>
		</div>
	</div>

</body>
</html>