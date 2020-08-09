package com.my.chat.room;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.my.chat.util.ChatMessage;
import com.my.chat.util.MessageType;

public class ChatRoom {
	
	private int roomId;
	private String roomName;
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>(); 

	public ChatRoom createRoom(String roomName) {
		
		ChatRoom chatRoom = new ChatRoom();
		chatRoom.roomId = sessionList.size()+1;
		chatRoom.roomName = roomName;
		
		return chatRoom;
	}
	
	 public void handleMessage(WebSocketSession session, ChatMessage chatMessage,
             ObjectMapper objectMapper) throws IOException {
		 
		 
		 if(chatMessage.getType() == MessageType.ENTER) {
			 sessionList.add(session);
			 chatMessage.setMessage(chatMessage.getNickname() +"님 등장!");
		 }
		 else if(chatMessage.getType() == MessageType.LEAVE) {
			 sessionList.remove(session);
			 chatMessage.setMessage(chatMessage.getNickname() +"님 퇴장!");
		 }
		 else {
			 chatMessage.setMessage(chatMessage.getNickname()+": "+chatMessage.getMessage());
		 }
		 send(chatMessage, objectMapper);
		 
	 }
	 
	 private void send(ChatMessage chatMessage, ObjectMapper objectMapper) throws IOException {
		 
		 TextMessage textMessage = new TextMessage(objectMapper.writeValueAsString(chatMessage.getMessage()));
		 
		 for(WebSocketSession sess : sessionList) {
			 sess.sendMessage(textMessage);
		 }
	 }
}
