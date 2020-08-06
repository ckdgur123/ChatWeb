package com.my.chat;	

import java.security.Principal;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.chat.data.userDAO;
import com.my.chat.util.LogInterceptor;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Principal principal,Model model) {
		
		
		
		if(principal != null) {
			
			userDAO dao = sqlSession.getMapper(userDAO.class);
			String nickname = dao.selectUserNickname(principal.getName());
			model.addAttribute("nickname", nickname);
		}
		
		
		return "index";
	}
	
	@RequestMapping("/errorPage/403")
	public String ErrorPage_403() {
		return "/errorPage/403";
	}
}
