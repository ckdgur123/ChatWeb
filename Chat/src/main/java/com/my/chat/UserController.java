package com.my.chat;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.my.chat.util.LogInterceptor;

@Controller
@RequestMapping("/user")
public class UserController {
	
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	
	@RequestMapping("/matching")
	public String matching(HttpServletRequest request,Model model) {
		
		String nickname = (String)request.getSession().getAttribute("nickname");
		model.addAttribute("nickname", nickname);
		
		return "/user/matching";
	}
}