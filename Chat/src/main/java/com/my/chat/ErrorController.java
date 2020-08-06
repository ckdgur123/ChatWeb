package com.my.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	@RequestMapping("/403")
	public String ErrorPage_403() {
		
		
		return "/errorPage/403";
	}
	
	@RequestMapping("/404")
	public String errorPage_404() {
		
		return "/errorPage/404";
	}
	
	@RequestMapping("/500")
	public String errorPage_500() {
		
		return "/errorPage/500";
	}
	
	@RequestMapping("/exists_user")
	public String exists_user(){
		return "/errorPage/exists_user";
	}
}
