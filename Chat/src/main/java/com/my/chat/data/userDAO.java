package com.my.chat.data;

import java.util.ArrayList;

public interface userDAO {
	
	public ArrayList<userDTO> selectList();
	public Integer selectUserId(String userId);
	public Integer selectNickname(String nickname);
	public void signupUser(String userId,String password,String nickname);
	public String getUserNickname(String userId);

}
