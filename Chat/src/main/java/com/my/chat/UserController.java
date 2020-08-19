package com.my.chat;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.my.chat.util.LogInterceptor;

@Controller
@RequestMapping("/user")
public class UserController {
	
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	
	@RequestMapping("/matching")
	public ModelAndView matching(HttpServletRequest request,Model model) {
		
		ModelAndView mv = new ModelAndView("/user/matching");
		
		String nickname = (String)request.getSession().getAttribute("nickname");
		mv.addObject("nickname", nickname);
		
		return mv;
	}
	
	@RequestMapping("/roomList")
	public String roomList(HttpServletRequest request,Model model) {
		
		String nickname = (String)request.getSession().getAttribute("nickname");
		model.addAttribute("nickname", nickname);
		
		return "/user/roomList";
	}
	
	@RequestMapping("/roomChatting")
	public String roomChatting(HttpServletRequest request,Model model) {
		
		String nickname = (String)request.getSession().getAttribute("nickname");
		String roomId = (String)request.getParameter("frmRoomId");
		String roomName = (String)request.getParameter("frmRoomName");
		model.addAttribute("nickname", nickname);
		model.addAttribute("roomId", roomId);
		model.addAttribute("roomName", roomName);
		
		return "/user/roomChatting";
	}
	
}


