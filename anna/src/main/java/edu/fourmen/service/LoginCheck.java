package edu.fourmen.service;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import edu.fourmen.vo.UserVO;


public class LoginCheck extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String requestUrl = request.getRequestURL().toString();
		
		if(requestUrl.contains("/sendRandomPwd") || requestUrl.contains("/checkEmailForFindPwd") || requestUrl.contains("/findPwd") || requestUrl.contains("/login") || requestUrl.contains("/logout") || requestUrl.contains("/join") || requestUrl.contains("/getKakaoAuthUrl") || requestUrl.contains("/kakaoLogin") || requestUrl.contains("/emailChk") || requestUrl.contains("/sendAuthEmail")){ 
			
			return true;
			
		} else {
			
			//System.out.println(session.getAttribute("uidx"));
			
			if(session.getAttribute("uidx") == null || session.getAttribute("userLoginInfo") == null) {
				
				session.invalidate();
				
				PrintWriter pw = response.getWriter();
				
				pw.append("<script>alert('로그인이 필요합니다'); location.href='"+request.getContextPath()+"/user/login.do';</script>");
				
				pw.flush();
				
				pw.close();
				
				return false;
				
			} else {
				
				if(requestUrl.contains("/admin")) {
					
					UserVO userLoginInfo = (UserVO)session.getAttribute("userLoginInfo");
					
					//System.out.println(userLoginInfo.getIsAdmin());
					
					String isAdmin = userLoginInfo.getIsAdmin();

					//System.out.println(isAdmin.equals("Y"));
					
					if(!isAdmin.equals("Y")){
						
						PrintWriter pw = response.getWriter();
						
						pw.append("<script>alert('잘못된 접근입니다.'); location.href='"+request.getContextPath()+"/';</script>");
						
						pw.flush();
						
						pw.close();
						
						return false;
						
					} else {
						
						return true;
						
					}
				} else {
					
					return true;	
					
				}
			}
		}
		
	}
	
}
