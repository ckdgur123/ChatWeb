package com.my.chat.room;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.my.chat.util.LogInterceptor;
import com.my.chat.util.MessageType;

public class ChatRoom {
	
	private String roomId;
	private String roomName;
	private String nickname;
	private String message;
	private int roomMaxUser;
	private int roomUserCount;
	private Map<String,WebSocketSession> sessionMatchedNicknameList =  new HashMap<String,WebSocketSession>();
	private RoomType roomType;
	private MessageType messageType;

	public void addUser(WebSocketSession session,String nickname) {
		sessionMatchedNicknameList.put(nickname,session);
		setRoomUserCount(sessionMatchedNicknameList.size());
	}
	
	public void removeUser(String nickname) {
		sessionMatchedNicknameList.remove(nickname);
		setRoomUserCount(sessionMatchedNicknameList.size());
	}

	public boolean CheckSession(WebSocketSession session) {
		
		return sessionMatchedNicknameList.containsValue(session);
	}
	
	public boolean CheckNickname(String nickname) {
		
		return sessionMatchedNicknameList.containsKey(nickname);
	}
	
	public void send(String sendMessage) throws Exception{
		Collection<WebSocketSession> sessionList = sessionMatchedNicknameList.values();
		for(WebSocketSession se : sessionList) {
			se.sendMessage(new TextMessage(sendMessage));
		}
	}

	public Set<String> getNicknameList() {
		return sessionMatchedNicknameList.keySet();
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public MessageType getMessageType() {
		return messageType;
	}

	public void setMessageType(MessageType messageType) {
		this.messageType = messageType;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getRoomUserCount() {
		return roomUserCount;
	}

	public void setRoomUserCount(int roomUserCount) {
		this.roomUserCount = roomUserCount;
	}

	public String getRoomId() {
		return roomId;
	}

	public int getRoomMaxUser() {
		return roomMaxUser;
	}

	public void setRoomMaxUser(int roomMaxUser) {
		this.roomMaxUser = roomMaxUser;
	}

	public RoomType getRoomType() {
		return roomType;
	}

	public void setRoomType(RoomType roomType) {
		this.roomType = roomType;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
}
