package edu.fourmen.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
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
	
	//회원가입 페이지
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String joinS1() {
		
		return "user/join";
		
	}
	
	
	
	//회원가입 step2 기본 회원정보 입력 및 회원가입 step3로 이동
	@RequestMapping(value="/join.do", method=RequestMethod.POST)
	public void joinS2(UserVO vo, HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		vo.setUser_pwd(pwdEncoder.encode(vo.getUser_pwd()));
		
		int result = userService.joinS1(vo);
		
		if(result == 1) {
			
			pw.append("<script>alert('환영합니다"+vo.getNickName()+"님, 가입이 완료되었습니다.'); location.href='"+request.getContextPath()+"/user/login.do';</script>");
			
			pw.flush();
			
			pw.close();
			
		} else {
			
			pw.append("<script>alert('문제가 발생하여 처리되지 않았습니다.\n다시 시도해주세요.'); location.href='"+request.getContextPath()+"/user/joinS2.do'</script>");
			
			pw.flush();
			
			pw.close();
			
		}
		
	}
	
	//가입된 이메일인지 확인후 인증 이메일을 보내는 Ajax
	@ResponseBody
	@RequestMapping(value="/emailChk.do", produces = "application/text; charset=utf8")
	public String emailChk(String user_email) {
		
		int result = userService.emailChk(user_email);
		
		return result+"";
	}
	
	@ResponseBody
	@RequestMapping(value="/sendAuthEmail.do",produces = "application/text; charset=utf8")
	public String sendAuthEmail(String user_email) {
		
		String authKey = mailService.sendAuthMail(user_email);
		
		return authKey;
	}
	
}
