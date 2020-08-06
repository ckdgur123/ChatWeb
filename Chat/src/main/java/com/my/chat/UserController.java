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
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		
		return "/loginForm";
	}
	
	@RequestMapping("/signupForm")
	public String signUpForm() {
		
		return "/signupForm";
	}
	
	@RequestMapping("/signup")
	public String signup(userDTO user) {
		
		userDAO dao = sqlSession.getMapper(userDAO.class);
		dao.signupUser(user.getUserId(), user.getPassword(), user.getNickname());
		
		return "redirect:/";
	}


}
