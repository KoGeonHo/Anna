package edu.fourmen.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import edu.fourmen.vo.UserVO;

public class CookieCheck extends HandlerInterceptorAdapter{

	@Autowired
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		//System.out.println("CookieCheckInterceptor????");
		
		HttpSession session = request.getSession();
		
		Cookie[] cookies = request.getCookies();
		
		for(Cookie cookie:cookies) {
			if(cookie.getName().equals("uidx")) {

				UserVO userLoginInfo = userService.keepLogin(Integer.parseInt(cookie.getValue()));
				
				//System.out.println("loginInfo:"+userLoginInfo);
				
				session.setAttribute("uidx", Integer.parseInt(cookie.getValue()));
				 
				session.setAttribute("userLoginInfo", userLoginInfo);
				
			}
		}
		
		String requestUrl = request.getRequestURL().toString();
		
		if(!requestUrl.contains("/kakaoLogin")){
			if(session.getAttribute("uidx") == null || session.getAttribute("userLoginInfo") == null) {
				session.invalidate();
			}
		}
		
		return true;
	}
}