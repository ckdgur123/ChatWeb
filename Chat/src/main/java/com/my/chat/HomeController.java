package com.my.chat;	

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.chat.data.userDAO;
import com.my.chat.data.userDTO;
import com.my.chat.util.LogInterceptor;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	Logger log = LoggerFactory.getLogger(LogInterceptor.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPwd;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(Principal principal,HttpServletRequest request, Model model) {
		
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nickname");
		
		if(principal != null && nick == null) {
			
			userDAO dao = sqlSession.getMapper(userDAO.class);
			String nickname = dao.getUserNickname(principal.getName());
			session.setAttribute("nickname", nickname);
			mv.addObject("nickname", nickname);
		}
		else
			mv.addObject("nickname", nick);
		
		mv.setViewName("index");
		
		return mv;
	}
	
	@RequestMapping("/loginForm")
	public String loginForm(Principal principal) {
		
		if(principal!=null)
			return "redirect:/errorPage/exists_user";
		
		return "/loginForm";
	}
	
	@RequestMapping("/signupForm")
	public String signUpForm(Principal principal) {
		
		if(principal!=null)
			return "redirect:/errorPage/exists_user";
		
		return "/signupForm";
	}
	
	@RequestMapping("/signup")
	public String signup(userDTO user) {
		
		userDAO dao = sqlSession.getMapper(userDAO.class);
		String encPassword = bcryptPwd.encode(user.getPassword());
		dao.signupUser(user.getUserId(), encPassword, user.getNickname());
		
		return "redirect:/";
	}
	
	@RequestMapping("/checkIdURL")
	@ResponseBody
	public Integer checkId(String userId) {
		
		userDAO dao = sqlSession.getMapper(userDAO.class);
		int checkValue = dao.selectUserId(userId);
		
		return Integer.valueOf(checkValue);
	}
	
	@RequestMapping("/checkNicknameURL")
	@ResponseBody
	public Integer checkNickname(String nickname) {
		
		userDAO dao = sqlSession.getMapper(userDAO.class);
		int checkValue = dao.selectNickname(nickname);
		
		return Integer.valueOf(checkValue);
	}
	
}
