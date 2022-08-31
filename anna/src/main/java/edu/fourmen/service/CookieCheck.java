package edu.fourmen.service;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.UserVO;

public class CookieCheck extends HandlerInterceptorAdapter{

	@Autowired
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		//System.out.println("CookieCheckInterceptor????");
		
		HttpSession session = request.getSession();
		
		Cookie[] cookies = request.getCookies();
		
		String requestUrl = request.getRequestURL().toString();
		
		if(!requestUrl.contains("/kakaoLogin")){
			
			if(session.getAttribute("uidx") == null || session.getAttribute("userLoginInfo") == null) {
				
				session.invalidate();
				
			}
		}
		
		session = request.getSession();
			
		for(Cookie cookie:cookies) {
			
			if(cookie.getName().equals("uidx")) {

				UserVO userLoginInfo = userService.keepLogin(Integer.parseInt(cookie.getValue()));
				
				//System.out.println("loginInfo:"+userLoginInfo);
				
				session.setAttribute("uidx", Integer.parseInt(cookie.getValue()));
				 
				session.setAttribute("userLoginInfo", userLoginInfo);
				
				if(session.getAttribute("locationSet") == null) {
					session.setAttribute("locationSet", userLoginInfo.getLocation_auth());
				}
				
			}
			
		}
		
		response.setContentType("text/html; charset=utf-8");
		
		if(session.getAttribute("uidx") != null) {
			int uidx = (int)session.getAttribute("uidx");
			
			//밴 체크 
			ReportVO rv = userService.BenCheck(uidx);
			//System.out.println(rv);
			if(rv != null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				
				Date date = new Date();
				Calendar cal = Calendar.getInstance();
				
				String today = format.format(date);
				
				date = format.parse(today);
				
				Date banDate = format.parse(rv.getBan_date());
				
				cal.setTime(banDate);
				
				int banterm = 0;
				if(rv.getBanCount() == 1) {
					banterm = 3;
				}else if(rv.getBanCount() == 2) {
					banterm = 7;
				}else if(rv.getBanCount() == 3) {
					banterm = 30;
				}else if(rv.getBanCount() > 3) {
					banterm = 1000000;
				}
				
				cal.add(Calendar.DATE,banterm);
				
				Date banEndDate = cal.getTime();
				
				
				int compare = banDate.compareTo(banEndDate);
				
				if(compare <= 0) {
					
					session.invalidate();
					
					PrintWriter pw = response.getWriter();
					
					String banReason = "";
					
					if(rv.getReport_type() == 0) {
						banReason = "No Show";
					}else if(rv.getReport_type() == 1) {
						banReason = "비속어&비매너 채팅 및 댓글";
					}else if(rv.getReport_type() == 2) {
						banReason = "게시물 규칙 위반";
					}else if(rv.getReport_type() == 3) {
						banReason = "허위 매물";
					}else if(rv.getReport_type() == 4) {
						banReason = rv.getContents();
					}
					
					pw.append("<script>alert('회원님은 다음 사유로 " + banterm + "일간 (" + format.format(banEndDate) + " 까지) 계정 정지 처리되었습니다\\n(사유 : " + banReason+ ")'); location.href='"+request.getContextPath()+"/main.do';</script>");
					
					pw.flush();
					
					pw.close();
					
					return false;
				}else {
					
					return true;
				}
				
				
			}
		}
		//System.out.println("벤데이터 없음");
			
		return true;
	}
		
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,ModelAndView modelAndView) throws Exception{
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("uidx") != null) {
			int uidx = (int)session.getAttribute("uidx");
			
			int chkAlarm = 0; 
			
			chkAlarm = userService.chkAlarm(uidx);
			
			int chkBuyNewMessage = 0; 
			
			chkBuyNewMessage = userService.chkBuyNewMessage(uidx);
			
			int chkSellNewMessage = 0; 
			
			chkSellNewMessage = userService.chkSellNewMessage(uidx);
			
			request.setAttribute("chkAlarm",chkAlarm);
			
			request.setAttribute("chkBuyNewMessage",chkBuyNewMessage);
			
			request.setAttribute("chkSellNewMessage",chkSellNewMessage);
		}
		
	}
		
}