package com.my.chat;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.my.chat.data.userDAO;
import com.my.chat.data.userDTO;

@Controller
public class UserController {
	
	@Autowired
	private SqlSession sqlSession;
	
}
