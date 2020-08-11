package com.my.chat.room;

import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoom {
	
	private String roomId;
	private String roomName;
	private String nickname;
	private int roomMaxUser;
	private int roomUserCount;
	private Set<WebSocketSession> sessionList =  new HashSet<WebSocketSession>();
	private Set<String> nicknameList = new HashSet<String>(); 
	
	public void addUser(WebSocketSession session,String nickname) {
		sessionList.add(session);
		nicknameList.add(nickname);
		setRoomUserCount(sessionList.size());
	}
	
	public boolean CheckSession(WebSocketSession session) {
		
		return sessionList.contains(session);
	}
	
	
	
	public Set<String> getNicknameList() {
		return nicknameList;
	}

	public boolean CheckNickname(String nickname) {
		
		return nicknameList.contains(nickname);
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

	private RoomType roomType;

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
