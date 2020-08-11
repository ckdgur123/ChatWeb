package com.my.chat.room;

import com.my.chat.util.ChatMessage;

public class RoomMessage extends ChatMessage{
	
	private String roomId;
	private String roomName;
	private int roomMaxUser;
	private int roomUserCount;
	
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getRoomMaxUser() {
		return roomMaxUser;
	}
	public void setRoomMaxUser(int roomMaxUser) {
		this.roomMaxUser = roomMaxUser;
	}
	public int getRoomUserCount() {
		return roomUserCount;
	}
	public void setRoomUserCount(int roomUserCount) {
		this.roomUserCount = roomUserCount;
	}
}
