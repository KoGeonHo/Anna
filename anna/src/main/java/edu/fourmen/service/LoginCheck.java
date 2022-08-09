package edu.fourmen.service;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginCheck extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String requestUrl = request.getRequestURL().toString();
		Cookie[] cookies = request.getCookies();
		
		for(Cookie cookie:cookies) {
			if(cookie.getName().equals("uidx")) {
<<<<<<< HEAD
				System.out.println("쿠키존재:"+cookie.getValue());
=======
				System.out.println(cookie.getValue()); 
				//System.out.println("cookie:"+Integer.parseInt(String.valueOf(cookieUidx)));
				//System.out.println("쿠키존재:"+cookie.getValue());
				//UserVO userLoginInfo = userService.keepLogin(Integer.parseInt(cookie.getValue()));
				
				
				//session.setAttribute("uidx", cookie.getValue());
				 
				//session.setAttribute("userLoginInfo", userLoginInfo);
				
				
				return true;
>>>>>>> parent of 89a0040 (Revert "Revert "20220809"")
			}
		}
		
		
		if(requestUrl.contains("/login") || requestUrl.contains("/join") || requestUrl.contains("/getKakaoAuthUrl") || requestUrl.contains("/kakaoLogin") || requestUrl.contains("/emailChk") || requestUrl.contains("/sendAuthEmail")){ 
			
			return true;
			
		} else {
			
			//System.out.println(session.getAttribute("uidx"));
			
			if(session.getAttribute("uidx") == null || session.getAttribute("userLoginInfo") == null) {
				
				PrintWriter pw = response.getWriter();
				
				pw.append("<script>alert('로그인이 필요합니다'); location.href='"+request.getContextPath()+"/user/login.do';</script>");
				
				pw.flush();
				
				pw.close();
				
				return false;
				
			} else {
				
				return true;	
				
			}
		}
		
	}
	
}
