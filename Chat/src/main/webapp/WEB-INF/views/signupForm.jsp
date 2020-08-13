<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 회원가입 </title>
<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>

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
				<li class="nav-item"><a class="nav-link" href="<c:url value="/user/matching" />">Group Chatting</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/user/roomList" />">Chatting Room</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/user/board" />">Board</a></li>
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


	<script type="text/javascript">
		var idCheck=false;
		var checkedIdValue='';
		var nicknameCheck=false;
		var checkedNicknameValue='';
		
		function checkValue(){
		    if(!document.userInfo.userId.value){
		        alert("아이디를 입력하세요.");
		        return false;
		    }
		    
		    if(!document.userInfo.password.value){
		        alert("비밀번호를 입력하세요.");
		        return false;
		    }
		    
		    if(!document.userInfo.nickname.value){
		        alert("닉네임을 입력하세요.");
		        return false;
		    }
		    
		    // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		    if(document.userInfo.password.value != document.userInfo.passwordConfirm.value ){
		        alert("비밀번호가 동일하지 않습니다!");
		        return false;
		    }

		    if(idCheck==false || checkedValue!=$('#userInfo #userId').val()){
				alert('아이디 중복체크를 해주세요.');
				return false;
			}

		    if(nicknameCheck==false || checkedNicknameValue!=$('#userInfo #nickname').val()){
				alert('닉네임 중복체크를 해주세요.');
				return false;
			}

		    return true;
		}

		function checkId(){

			if(!document.userInfo.userId.value){
				alert("아이디를 입력하세요.");
		        return;

			}
			var formData = $('#userInfo').serialize();

			$.ajax({
				url:"checkIdURL",
				type:"post",
				data:formData,
				success:function(data){
					if(data <= 0){
						alert('사용가능한 아이디입니다.');
						idCheck=true;
						checkedValue=$('#userInfo #userId').val();
					}
					else{
						alert('이미 존재하는 아이디입니다.');
					}
				},
				error:function(){
					alert('ajax error!');
				}
			});
		}
		
		function checkNickname(){

			if(!document.userInfo.nickname.value){
				alert("닉네임을 입력하세요.");
		        return;

			}
			var formData = $('#userInfo').serialize();

			$.ajax({
				url:"checkNicknameURL",
				type:"post",
				data:formData,
				success:function(data){
					if(data <= 0){
						alert('사용가능한 아이디입니다.');
						nicknameCheck=true;
						checkedNicknameValue=$('#userInfo #nickname').val();
						
					}
					else{
						alert('이미 존재하는 닉네임입니다.');
					}
				},
				error:function(){
					alert('ajax error!');
				}
			});
		}
	
	</script>

	<div class="row text-center" style="width: 100%">
		<div style="width: 30%; float: none; margin: 0 auto;">
			<div style="height:30%;"></div>
			
			<form method="post" action="<c:url value="/signup" />"
				name="userInfo" onsubmit="return checkValue();" id=userInfo>
				<div class="form-group">
					<label for="userId">아이디</label>
					<input type="text" class="form-control" name="userId" id="userId"><br/>
					<button type="button" onclick="checkId();" class="btn btn-info"> 아이디 확인 </button>
				</div>
				<div class="form-group">
					<label for="password">패스워드</label>
					<input type="password" class="form-control" name="password">
				</div>
				<div class="form-group">
					<label for="passwordConfirm">패스워드 확인</label>
					<input type="password" class="form-control" name="passwordConfirm">
				</div>
				<div class="form-group">
					<label for="nickname">닉네임</label>
					<input type="text" class="form-control" name="nickname" id="nickname"><br/>
					<button type="button" onclick="checkNickname();" class="btn btn-info"> 닉네임 확인 </button>
				</div>
				<br/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" value="회원가입" class="btn btn-success">
			</form>

		</div>
	</div>

</body>
</html>