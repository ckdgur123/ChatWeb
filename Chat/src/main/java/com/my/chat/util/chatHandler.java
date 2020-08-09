package com.my.chat.util;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;

public class chatHandler extends TextWebSocketHandler{
	
	Logger log = LoggerFactory.getLogger(chatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private int userCount;
	
	/*
	 * handleTextMessage : 클라이언트가 메세지 전송 시 호출되는 메소드 
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String msg = message.getPayload();
		
		//ObjectMapper = JSON 타입의 데이터를 클래스로 매핑해주는 클래스
		ObjectMapper objectMapper = new ObjectMapper();
		ChatMessage chatMessage = objectMapper.readValue(msg, ChatMessage.class);

		if(chatMessage.getType() == MessageType.ENTER) {
			sessionList.add(session);
			chatMessage.setMessage("☆★"+chatMessage.getNickname()+"님 등장!"+"☆★");
		}
		else if(chatMessage.getType() == MessageType.LEAVE) {
			chatMessage.setMessage("☆★"+chatMessage.getNickname()+"님 퇴장!"+"☆★");
			sessionList.remove(session);
		}
		else {
			chatMessage.setMessage(chatMessage.getNickname()+": "+ chatMessage.getMessage());
		}
		TextMessage textMessage = new TextMessage(objectMapper.writeValueAsString(chatMessage.getMessage()));
		sendUserCount(chatMessage.getType(), textMessage);
		
	}
	
	public void sendUserCount(MessageType type, TextMessage textMessage) throws Exception{
		
		if(type == MessageType.CHAT) {
			
			for(WebSocketSession se : sessionList)
				se.sendMessage(textMessage);
			
		}
		else {
			
			userCount=sessionList.size();
			for(WebSocketSession se : sessionList) {
				se.sendMessage(new TextMessage(Integer.toString(userCount)));
				se.sendMessage(textMessage);
			}
		}
	}
	
	/*
	 * afterConnectionEstablished, afterConnectionClosed 메소드의 역할을 각각 
	 * handleTextMessage의 MessageType이 ENTER, LEAVE일 때로 수행할 수 있다.
	 *  @Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			log.info(session.getId() + " 연결됨 ");
		}
	 *  @Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		}
	 */
}
