package edu.fourmen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
	//회원가입 페이지
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String joinS1() {
		
		return "user/join";
		
	}
	
	//로그인 처리
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(UserVO vo, HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		UserVO userInfo = userService.login(vo);

		if(userInfo == null) {
			
			System.out.println("가입되지 않은 이메일주소");
			
			pw.append("<script>alert('가입되지 않은 이메일 주소입니다.'); history.back();</script>");
			
			pw.flush();
			
			pw.close();
			
			
		}else if(pwdEncoder.matches(vo.getUser_pwd(), userInfo.getUser_pwd())) {
			
			System.out.println("비밀번호 일치");
			
			session = request.getSession(); 
			
			session.setAttribute("userInfo", userInfo);
			
			pw.append("<script>location.href='"+request.getContextPath()+"/main.do';</script>");
			
			pw.flush();
			
			pw.close();
			
		} else {
			System.out.println("비밀번호 불일치");
			
			pw.append("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
			
			pw.flush();
			
			pw.close();
		}	
	}
	
	//로그아웃 처리
	@RequestMapping(value="/logout.do")
	public String logOut(HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		session.invalidate();
		
		return "";
	}
	
	//회원가입  데이터 입력
	@RequestMapping(value="/join.do", method=RequestMethod.POST)
	public void joinS2(UserVO vo, HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		vo.setUser_pwd(pwdEncoder.encode(vo.getUser_pwd()));
		
		int result = userService.join(vo);
		
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
	
	//카카오 인증 Api URL 가져오는 Ajax
	@ResponseBody
	@RequestMapping(value = "/getKakaoAuthUrl.do", produces = "application/text; charset=utf8")
	public String getKakaoAuthUrl() {
		
		String reqUrl = "https://kauth.kakao.com/oauth/authorize";
		reqUrl += "?client_id="+userService.getClient_id();
		reqUrl += "&redirect_uri="+userService.getRedirect_uri();
		reqUrl += "&response_type=code";
		
		return reqUrl;
	}
	
	//카카오 연동정보 조회
	@RequestMapping(value = "/kakaoLogin.do")
	public String oauthKakao(String code, Model model,RedirectAttributes ra) {

		HashMap<String,Object> kakaoInfo = userService.getAccessToken(code);
		
        String access_Token = (String)kakaoInfo.get("access_Token");
	
        HashMap<String, Object> userInfo = userService.getUserInfo(access_Token);
        
        if(!kakaoInfo.get("responseCode").equals(200)) {
        	
        } else {
        	
        	String user_email = (String)userInfo.get("kakao_email");
        	
        	int result = userService.emailChk(user_email);
        	
        	if(result == 0) {
        		
        		String kakao_email = (String)userInfo.get("kakao_email");
            	String kakao_nickName = (String)userInfo.get("nickName");
            	String kakaoId = (String)userInfo.get("kakaoId");
            	String thumbnail_image = (String)userInfo.get("thumbnail_image");
            	
            	UserVO vo = new UserVO();
            	
            	vo.setUser_email(kakao_email);
            	vo.setNickName(kakao_nickName);
            	vo.setKakao_auth(kakaoId);
            	vo.setProfile_image(thumbnail_image);
            	
            	if(userService.join(vo) !=1) {
            		System.out.println("정상처리됨");
            	} else {
            		System.out.println("오류발생");
            	}
            	
        	} else {
        		
        		System.out.println("가입된 이메일 주소 카카오 id update");
        		
        	}
        	
        	
        }
        
        
        
        return "redirect:/main.do"; //본인 원하는 경로 설정
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
