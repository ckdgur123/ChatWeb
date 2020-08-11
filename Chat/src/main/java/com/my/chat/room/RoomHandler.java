package com.my.chat.room;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.my.chat.util.LogInterceptor;

public class RoomHandler extends TextWebSocketHandler{
	
	private ObjectMapper objectMapper;
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	private Map<String,ChatRoom> map = new HashMap<String,ChatRoom>();
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	/*
	 * 새로운 방만들기 메세지가 들어오면, 그 방 ID(번호) : 방 으로 MAP을 만들어서
	 * 맵에 session을 집어넣고, 해당 방에 메세지가 들어오면 해당하는 방의 session들에게만 메세지를 뿌린다. 
	 * */
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		objectMapper = new ObjectMapper();
		ChatRoom chatRoom = objectMapper.readValue(message.getPayload(), ChatRoom.class);
		
		// roomType 이 message로 올 때 = 방 만들기/제거 했을 때
		if(chatRoom.getRoomType() == RoomType.CREATE) {
			
			chatRoom.setRoomId(Integer.toString(map.size()+1));
			map.put(Integer.toString(map.size()+1), chatRoom);
			chatRoom.addUser(session, chatRoom.getNickname());
			
			String sendMessage = objectMapper.writeValueAsString(chatRoom);
			allSessionSend(sendMessage);
			return;
		}
		else if(chatRoom.getRoomType() == RoomType.REMOVE) {
			map.remove(chatRoom.getRoomId());
		}
		else {
			ChatRoom room = map.get(chatRoom.getRoomId());
			if ( room.getRoomMaxUser() <= room.getRoomUserCount()) {
				noEnter(session,"인원이 꽉 찼습니다.");

			}
			else {
				if(!room.CheckSession(session) && !room.CheckNickname(chatRoom.getNickname())) {
					
					room.addUser(session,chatRoom.getNickname());
					map.replace(room.getRoomId(), room);
					room.setRoomType(RoomType.ENTER);
					String roomMessage = objectMapper.writeValueAsString(room);
					allSessionSend(roomMessage);
					room.setRoomType(RoomType.CREATE);
				}
				else
					noEnter(session,"이미 참여하고 있는 방입니다.");
			}
		}
	}
	
	public void allSessionSend(String sendMessage) throws Exception{
		for(WebSocketSession se : sessionList) {
			se.sendMessage(new TextMessage(sendMessage));
		}
	}

	public void noEnter(WebSocketSession session,String message) throws Exception{
		JSONObject jsonMessage = new JSONObject();
		jsonMessage.put("roomType", "NO_ENTER");
		jsonMessage.put("message", message);
		session.sendMessage(new TextMessage(jsonMessage.toJSONString()));
	}
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sessionList.add(session);
		log.info(session.getId() +" 연결됨");
		
		for(String key : map.keySet()) {
			ChatRoom room = map.get(key);
			String roomData = objectMapper.writeValueAsString(room);
			session.sendMessage(new TextMessage(roomData));
		}
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info(session.getId() +" 연결해제됨");
	}
	
}



