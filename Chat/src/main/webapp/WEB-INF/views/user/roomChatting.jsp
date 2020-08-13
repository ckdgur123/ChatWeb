<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="j" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>


<!-- 무료아이콘 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel=stylesheet href=../resources/chatting.css>

</head>


<body>


	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

		<a class="navbar-brand" href="<c:url value="/" />"> <i
			class="fa fa-heart" aria-hidden="true"></i> 채팅
		</a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link"
					href="<c:url value="/" />">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<c:url value="/user/matching" />">Group Chatting</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<c:url value="/user/roomList" />">Chatting Room</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<c:url value="/user/board" />">Board</a></li>
			</ul>

			<div style="text-align: right; width: 10%;">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <!--  로그인 하지 않으면 Guest 로 보이고, 로그인하면 닉네임이 보이도록 설정-->
							<sec:authorize access="isAnonymous()">
								Guest
							</sec:authorize> <sec:authorize access="isAuthenticated()">
								<span style="color: white;">${nickname} </span>님
							</sec:authorize>
					</a>

						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<sec:authorize access="isAnonymous()">
								<a class="dropdown-item" href="<c:url value="/loginForm" />">로그인</a>
								<a class="dropdown-item" href="<c:url value="/signupForm" />">회원가입</a>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<a class="dropdown-item" href="<c:url value="/updateUser" />">회원정보수정</a>
								<a class="dropdown-item" href="#"
									onclick="document.getElementById('logout-form').submit();">로그아웃</a>
								<form id="logout-form" action='<c:url value='/logout'/>'
									method="POST">
									<input name="${_csrf.parameterName}" type="hidden"
										value="${_csrf.token}" />
								</form>

								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Something else here</a>
							</sec:authorize>


						</div></li>
				</ul>
			</div>

		</div>
	</nav>


	<script>
		var websocket;
		var nickname = '<c:out value="${nickname}"/>';
		var roomId = '<c:out value="${roomId}"/>';
		var roomName = '<c:out value="${roomName}"/>';
		var count;

		websocket = new SockJS(
				"http://localhost:8080/chat/user/roomMatching/echo/");
		websocket.onclose = function() {
			disconnect();
		}

		websocket.onopen = function() {
			websocket.send(JSON.stringify({
				roomType : 'CHAT',
				messageType : 'ENTER',
				roomId : roomId,
				nickname : nickname
			}));
		}

		websocket.onmessage = function(evt) {

			var roomMessageData = JSON.parse(evt.data);
			console.log(roomMessageData);

			if (evt.data.length == 1) {
				count = evt.data;
				$('#userCount').text("현재 접속 인원: " + count);
			} else if (roomMessageData.messageType == 'CHAT') {
				let today = new Date();
				$('#chattingLog').append("[" + today.toLocaleString() + "] ");
				$('#chattingLog').append(roomMessageData.message);
				$('#chattingLog').append("<br/>");
				$("#chattingLog").scrollTop($("#chattingLog")[0].scrollHeight);
			} else if (roomMessageData.messageType == 'ENTER') {

				$('#chattingLog').append("# ");
				$('#chattingLog').append(roomMessageData.message);
				$('#chattingLog').append("<br/>");
				$("#chattingLog").scrollTop($("#chattingLog")[0].scrollHeight);
			} else if (roomMessageData.messageType == 'LEAVE') {

				$('#chattingLog').append("# ");
				$('#chattingLog').append(roomMessageData.message);
				$('#chattingLog').append("<br/>");
				$("#chattingLog").scrollTop($("#chattingLog")[0].scrollHeight);
			}
		}

		function enterKey() {
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}

		function sendMessage() {
			if ($('#message').val() != '') {
				var msg = $("#message").val();
				websocket.send(JSON.stringify({
					roomType : 'CHAT',
					messageType : 'CHAT',
					roomId : roomId,
					nickname : nickname,
					message : msg
				}));
				$('#message').val('');
			}
		}

		function disconnect() {
			if (websocket !== undefined
					&& websocket.readyState !== WebSocket.CLOSED) {
				if (confirm('채팅방을 나가시겠습니까?')) {
					websocket.send(JSON.stringify({
						roomType : 'CHAT',
						messageType : 'LEAVE',
						roomId : roomId,
						nickname : nickname
					}));
					websocket.close();
					location.href = '<c:url value="/user/roomList" />';
				}
			}
		}

		window.onbeforeunload = function() {
			if (websocket !== undefined
					&& websocket.readyState !== WebSocket.CLOSED) {
				websocket.send(JSON.stringify({
					roomType : 'CHAT',
					messageType : 'LEAVE',
					roomId : roomId,
					nickname : nickname
				}));
				websocket.close();
			}
		}
	</script>

	<div class=container
		style="border-right: 4px solid black; border-left: 4px solid black;">
		<div class=container
			style="border-bottom: 4px dashed gray; margin-top: 10px;">
			<div class="text-center" style="font-size: 30px; font-weight: bold;">
				${roomId}번방 - ${roomName}</div>
			<div id="userCount"
				style="text-align: right; font-size: 18px; font-weight: bold;">
			</div>
		</div>
		<div class=container>
			<div class="chatBorder">
				<div id=chattingLog style="max-height: 50px;"></div>

				<div class=footer>
					<div style="text-align: right; margin: 10px;">
						<div id="guideMessage"></div>
						<button onclick="disconnect();" class="btn btn-danger">
							나가기</button>
					</div>

					<input type="text" id="message" onkeyup="enterKey();">
					<button onclick="sendMessage();" class="btn btn-info">Send</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>