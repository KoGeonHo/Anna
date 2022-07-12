package edu.fourmen.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.fourmen.service.MailService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.UserVO;

@RequestMapping(value="/user")
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder; 
	
	//로그인 페이지
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login() {
		
		return "user/login";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String loginOk(UserVO vo) {
		
		return "redirect:/user/login.do";
		
	}
	
	//회원가입 step1 페이지
	@RequestMapping(value="/joinS1.do", method=RequestMethod.GET)
	public String joinS1() {
		
		return "user/joinS1";
		
	}
	
	
	//회원가입 step2 페이지
	@RequestMapping(value="/joinS2.do", method=RequestMethod.GET)
	public String joinS2() {
		
		return "user/joinS2";
		
	}
	
	
	//회원가입 step2 기본 회원정보 입력 및 회원가입 step3로 이동
	@RequestMapping(value="/joinS2.do", method=RequestMethod.POST)
	public String joinS2(UserVO vo, HttpServletRequest request) {
		
		vo.setUser_pwd(pwdEncoder.encode(vo.getUser_pwd()));
		
		int result = userService.joinS1(vo);
		
		request.setAttribute("user_email",vo.getUser_email());
		request.setAttribute("nickName",vo.getNickName());
		
		return "user/joinS3";
		
	}
	
	//회원가입 step3 이메일 인증 페이지
	@RequestMapping(value="/joinS3.do", method=RequestMethod.GET)
	public String joinS3(UserVO vo) {
		
		mailService.sendAuthMail(vo.getUser_email());
		
		return "user/joinS3";
		
	}
	

	//가입된 이메일인지 확인하는 AJAX
	@ResponseBody
	@RequestMapping(value="/emailChk.do", produces = "application/text; charset=utf8")
	public String emailChk(String user_email) {
		
		//System.out.println(user_email);
		
		int result = userService.emailChk(user_email); 
		
		return result+"";
	}
	
}
