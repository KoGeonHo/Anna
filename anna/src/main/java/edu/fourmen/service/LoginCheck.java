package edu.fourmen.service;

import java.io.PrintWriter;

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
		
		if(requestUrl.contains("/login") || requestUrl.contains("/join") || requestUrl.contains("/getKakaoAuthUrl") || requestUrl.contains("/kakaoLogin") || requestUrl.contains("/emailChk") || requestUrl.contains("/sendAuthEmail") || requestUrl.contains("/updateKeyword")){ 
			
			return true;
			
		} else {
			
			//System.out.println(session.getAttribute("uidx"));
			
			if(session.getAttribute("uidx") == null) {
				
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
