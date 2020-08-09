package com.my.chat.room;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.my.chat.util.ChatMessage;
import com.my.chat.util.LogInterceptor;

public class RoomHandler extends TextWebSocketHandler{
	
	private ObjectMapper objectMapper;
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String msg = message.getPayload();
		log.info("메세지 전송 = {}: {}",session.getId(), msg);
		
		ChatMessage chatMessage = objectMapper.readValue(msg, ChatMessage.class);
		
	}

}
