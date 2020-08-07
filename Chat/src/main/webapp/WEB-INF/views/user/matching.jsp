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

    <script>
        var websocket;
        var nickname = '<c:out value="${nickname}"/>';
        
        function connectSocket(){
            websocket = new SockJS("http://localhost:8080/chat/user/matching/echo");
            $('#guideMessage').text('연결됨');
            
            websocket.onopen = function(){
            	websocket.send(nickname+"님 등장!");
            }
            websocket.onmessage = function(evt){
            	$('#chattingLog').append(evt.data);
            	$('#chattingLog').append("<br/>");
           }
        }

        function sendMessage(){
            websocket.send(nickname+ ": "+$("#message").val());
            $('#message').val('');
	    }
	    
    	function disconnect(){
    		websocket.close();
    	}

    </script>
</head>


<body>
    <div class=container style="margin:20px;">
		<input type="text" id="message"/>
		<button onclick="sendMessage();">Send</button>
    </div>
    <div class=container>
    	<button onclick="connectSocket();"> 연결 </button>
        <button onclick="disconnect();"> 종료 </button>
    	<h5 id="guideMessage"></h5>
    	<div id="chattingLog"></div>
    </div>
    
</body>
</html>