<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="j" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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


<!-- 무료아이콘 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel=stylesheet href=../resources/chatting.css>
	
    <script>
        var websocket;
        var nickname = '<c:out value="${nickname}"/>';
        
        
        function connectSocket(){
        	if(websocket !== undefined && websocket.readyState !== WebSocket.CLOSED ){
            	writeResponse("WebSocket is already opened.");
            	return;
            }

            websocket = new SockJS("http://localhost:8080/chat/user/matching/echo");
            $('#guideMessage').text('연결됨');
            
            websocket.onopen = function(){
            	websocket.send(nickname+"님 등장!");
            }
            websocket.onmessage = function(evt){
            	let today = new Date(); 
            	$('#chattingLog').append("["+today.toLocaleString()+"] ");
            	$('#chattingLog').append(evt.data);
            	$('#chattingLog').append("<br/>");
                $("#chattingLog").scrollTop($("#chattingLog")[0].scrollHeight);
            }
            websocket.onclose = function(){
        		websocket.send(nickname+"님 퇴장!");
            }	
        }

		function enterKey(){
	        if(window.event.keyCode==13){
				sendMessage();
	       	}
		}


        function sendMessage(){
            if($('#message').val()!= ''){
                websocket.send(nickname+ ": "+$("#message").val());
                $('#message').val('');
            }

	    }
	    
    	function disconnect(){
    		websocket.send(nickname+"님 퇴장!");
    		websocket.close();
    		$('#guideMessage').text('연결종료');
    	}

    </script>
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
	<div class=container style="border-right: 4px solid black;border-left: 4px solid black;">
		<div class=container style="border-bottom: 4px dashed gray; margin-top:10px;" >
			<h3 class="text-center" > Chatting </h3>
		</div>
		<div class=container>
			<div class="chatBorder">
				<div id=chattingLog style="max-height:50px;"></div>
				
				<div class=footer>
					<div style="text-align:right; margin:10px;">
						<div id="guideMessage" ></div>
						<button onclick="connectSocket();" class="btn btn-success"> 연결 </button>
			        	<button onclick="disconnect();" class="btn btn-danger"> 종료 </button>
					</div>			
			        
					<input type="text" id="message" onkeyup="enterKey();">
					<button onclick="sendMessage();" class="btn btn-info">Send</button>
				</div>	
		    </div>
		</div>
	</div>
	
	

    
</body>
</html>