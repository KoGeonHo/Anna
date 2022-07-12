package edu.fourmen.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.fourmen.service.UserService;
import edu.fourmen.vo.UserVO;

@RequestMapping(value="/user")
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login() {
		
		return "user/login";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String loginOk(UserVO vo) {
		
		
		
		return "redirect:/user/login.do";
		
	}
	
	@RequestMapping(value="/joinS1.do", method=RequestMethod.GET)
	public String joinS1() {
		
		return "user/joinS1";
		
	}
	
	@RequestMapping(value="/joinS2.do", method=RequestMethod.GET)
	public String joinS2() {
		
		return "user/joinS2";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/emailChk.do", produces = "application/text; charset=utf8")
	public String emailChk(String user_email) {
		
		System.out.println(user_email);
		
		int result = userService.emailChk(user_email); 
		
		return result+"";
	}
	
}
