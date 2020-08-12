package com.my.chat.room;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.WebSocketSession;

import com.my.chat.util.MessageType;

public class ChatRoom {
	
	private String roomId;
	private String roomName;
	private String nickname;
	private String message;
	private int roomMaxUser;
	private int roomUserCount;
	private Map<String,WebSocketSession> sessionList =  new HashMap<String,WebSocketSession>();
	private Set<String> nicknameList = new HashSet<String>(); 
	private RoomType roomType;
	private MessageType messageType;

	public void addUser(WebSocketSession session,String nickname) {
		sessionList.put(nickname,session);
		nicknameList.add(nickname);
		setRoomUserCount(sessionList.size());
	}

	public boolean CheckSession(WebSocketSession session) {
		
		return sessionList.containsValue(session);
	}
	
	public boolean CheckNickname(String nickname) {
		
		return nicknameList.contains(nickname);
	}

	public Set<String> getNicknameList() {
		return nicknameList;
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
