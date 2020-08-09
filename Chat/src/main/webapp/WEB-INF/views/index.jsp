<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="j" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Home</title>
<!--  ${pageContext.request.contextPath}/assets/파일경로  -->

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

</head>
<body>

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



	<div class="container" style="width: 100%; height: 100%;">
		<div class="row" style="width: 100%; height: 35%;"></div>

		<div class="mx-auto" style="width: 230px;">
			<sec:authorize access="isAnonymous()">
				<p><a class="btn btn-secondary btn-lg btn-block" href="<c:url value="/loginForm" />"> 로그인 </a></p>
				<p><a class="btn btn-secondary btn-lg btn-block" href="<c:url value="/signupForm" />"> 회원가입 </a></p>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<h5 style="text-align:center;"> ${nickname } 님, 안녕하세요! </h5>
				<p><a class="btn btn-secondary btn-lg btn-block" href="<c:url value="/user/matching" />"> 매칭하기 </a></p>
				<p><a class="btn btn-secondary btn-lg btn-block" href="<c:url value="/user/roomList" />"> 채팅방 </a></p>
				<p><a class="btn btn-secondary btn-lg btn-block" href="<c:url value="/user/board" />"> 게시판 </a></p>
			</sec:authorize>
			
		</div>
	</div>


</body>
</html>
