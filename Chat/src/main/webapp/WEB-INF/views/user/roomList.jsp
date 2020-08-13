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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
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
        var websocket;
        var nickname = '<c:out value="${nickname}"/>';
		var count;
		var roomDataArray = new Array();

		websocket = new SockJS("http://localhost:8080/chat/user/roomMatching/echo/");
        websocket.onclose = function(){
			disconnect();
    	}
    	websocket.onopen = function(){
        	websocket.send(JSON.stringify({
				roomType:'GET_LIST'
			}));
        }
    	websocket.onmessage=function(evt){
			
			var roomData = JSON.parse(evt.data);
			console.log(roomData);
			
			if(roomData.roomType=='CREATE'){
				roomDataArray.push(roomData);
				drawTable(roomData);
			}
			else if (roomData.roomType=='ENTER'){
				updateTable();
			}
			else if(roomData.roomType=='RELOAD'){
				updateTable();
			}
			else if (roomData.roomType=='NO_ENTER'){
				alert(roomData.message);
			}
			else if(roomData.roomType=='SEND_ROOMID'){
				$('#frmRoomId').val(roomData.message);
				$('#frmRoomName').val(roomData.roomName);
				$('#frm').submit();
			}
        }

        function updateTable(){
			location.reload();
        }

    	function drawTable(roomData) {
    		$('#table tbody').append('<tr value='+roomData.roomId+'><td id=roomId>'+roomData.roomId+
    	    		'</td><td>'+roomData.roomName+'</td><td>'+
    	    		roomData.roomUserCount+' / '+roomData.roomMaxUser+
    	    		'</td><td>'+'<button class="btn btn-success" onclick="enterRoom('+roomData.roomId+');">입장</button></td></tr>');
    	}

    	function enterRoom(roomId){
			websocket.send(JSON.stringify({
				roomType:"ENTER",
				roomId:roomId,
				nickname:nickname
			}));
        }

        function createRoom(){
        	if($('#roomName').val()!= ''){
				var roomName = $('#roomName').val();
				var roomMaxUser = $('#roomMaxUser').val();
				$('#roomName').val('');
				$('#roomMaxUser').val('2');
				websocket.send(JSON.stringify({
					roomType:"CREATE",
					roomName:roomName,
					roomUserCount:"1",
					roomMaxUser:roomMaxUser,
					nickname:nickname
				}));
			};
        }	

    	function disconnect(){
        	if(websocket !== undefined && websocket.readyState !== WebSocket.CLOSED ){
            	
        		websocket.close();
        	}
    	}

    	window.onbeforeunload = function() {
        	disconnect();
        }

    </script>

	<div class="modal fade" id="createNewRoom" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">방 만들기</h4>
				</div>
				<div class="modal-body">
					<label> 제목 </label> <input class=form-control type=text
						id="roomName"> <label> 인원 </label><br /> <select
						id="roomMaxUser" form="createRoomForm" class="form-control">
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="createRoom();" data-dismiss="modal">만들기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">
						닫기</button>
				</div>
			</div>
		</div>
	</div>


	<table class="table table-striped" style="text-align: center;" id=table>
		<thead>
			<tr>
				<th>번호</th>
				<th>방 이름</th>
				<th>인원</th>
				<th>입장</th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
	</table>
	<div style="text-align: right;">
		<button class="btn btn-primary" data-toggle="modal"
			data-target="#createNewRoom" style="margin: 20px;">새로 만들기</button>
	</div>
	
	<form id=frm method=post action=<c:url value="/user/roomChatting" />>
		<input type=hidden id=frmRoomId name=frmRoomId>
		<input type=hidden id=frmRoomName name=frmRoomName>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>


</body>
</html>