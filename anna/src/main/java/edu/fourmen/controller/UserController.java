package edu.fourmen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
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

import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.MailService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.UserVO;

@RequestMapping(value="/user")
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BoardItemService boardItemService;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder; 
	
	String path = "/anna";
	
	//로그인 페이지
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login(HttpServletResponse response,HttpServletRequest request,HttpSession session) {
		
		return "user/login";
		
	}
		
	//회원가입 페이지
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String join() {
		
		return "user/join";
		
	}
	
	//로그인 처리
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(UserVO vo, HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println(vo.getKeepLogin());
		
		PrintWriter pw = response.getWriter();
		
		UserVO userInfo = userService.login(vo);

		if(userInfo == null) {
			
			System.out.println("가입되지 않은 이메일주소");
			
			pw.append("<script>alert('가입되지 않은 이메일 주소입니다.'); history.back();</script>");
			
			pw.flush();
			
			pw.close();
			
			
		} else {
			
			System.out.println("kakao_auth : " + userInfo.getKakao_auth());
			
			if(userInfo.getKakao_auth() == null) {
				
				if(pwdEncoder.matches(vo.getUser_pwd(), userInfo.getUser_pwd())){
					
					System.out.println("비밀번호 일치");
					
					session = request.getSession(); 

					session.setMaxInactiveInterval(60*60);

					session.setAttribute("uidx", userInfo.getUidx());
					
					session.setAttribute("userLoginInfo", userInfo);
					
					//로그인 유지체크를 한경우 쿠키를생성한다.
					if(vo.getKeepLogin() != null) {
			        	if(vo.getKeepLogin().equals("true")) {
			        		int uidx = userInfo.getUidx();
			        		Cookie cookie = new Cookie("uidx",Integer.toString(uidx));
			        		cookie.setPath("/");
			        		cookie.setMaxAge(60*60*24*7);//쿠키유지 일주일
			        		response.addCookie(cookie);
			        	}
					}
					pw.append("<script>location.href='"+request.getContextPath()+"/main.do';</script>");
					
					pw.flush();
					
					pw.close();
					
				} else {
					
					System.out.println("비밀번호 불일치");
					
					pw.append("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
					
					pw.flush();
					
					pw.close();
					
				}
				
			} else {
				
				pw.append("<script>alert('카카오 계정과 연동된 아이디 입니다. \\n카카오 로그인 하기를 눌러주시면 간편 로그인이 가능합니다.'); history.back();</script>");
				
				pw.flush();
				
				pw.close();
				
			}
			
		} 	
	}
	
	//로그아웃 처리
	@RequestMapping(value="/logout.do")
	public String logOut(HttpServletRequest request,HttpServletResponse response,HttpSession session) {
		
		session = request.getSession();
		
		String access_Token = (String)session.getAttribute("access_Token");
		
		userService.kakaoLogout(access_Token);
		
		session.invalidate();
		Cookie[] cookies = request.getCookies();  // 쿠키 값을 null로 설정
		
		for(Cookie cookie:cookies) {
			if(cookie.getName().equals("uidx")) {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
		
		return "redirect:/main.do";
	}
	
	//회원가입  데이터 입력
	@RequestMapping(value="/join.do", method=RequestMethod.POST)
	public void join(UserVO vo, HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		vo.setUser_pwd(pwdEncoder.encode(vo.getUser_pwd()));
		
		int result = userService.join(vo);
		
		if(result == 1) {
			
			pw.append("<script>alert('환영합니다"+vo.getNickName()+"님, 가입이 완료되었습니다.'); location.href='"+request.getContextPath()+"/user/login.do';</script>");
			
			pw.flush();
			
			pw.close();
			
		} else {
			
			pw.append("<script>alert('문제가 발생하여 처리되지 않았습니다.\\n다시 시도해주세요.'); location.href='"+request.getContextPath()+"/user/joinS2.do'</script>");
			
			pw.flush();
			
			pw.close();
			
		}
		
	}		
	
	//카카오 인증 Api URL 가져오는 Ajax
	@ResponseBody
	@RequestMapping(value = "/getKakaoAuthUrl.do", produces = "application/text; charset=utf8")
	public String getKakaoAuthUrl(String keepLogin,HttpServletRequest request, HttpSession session) {
		
		if(keepLogin.equals("false")) {
			System.out.println("false");
		}else {
			System.out.println("true");
		}
		
		session = request.getSession();
		
		session.setAttribute("keepLogin",keepLogin);
		
		String reqUrl = "https://kauth.kakao.com/oauth/authorize";
		reqUrl += "?client_id="+userService.getClient_id();
		reqUrl += "&redirect_uri="+userService.getRedirect_uri();
		reqUrl += "&response_type=code";
		
		return reqUrl;
	}
	
	//카카오 연동정보 조회 및 로그인 처리
	@RequestMapping(value = "/kakaoLogin.do")
	public void oauthKakao(String code, HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IOException {

		//오류 발생시의 메세지
        String msg = "";
        
        //처리후 이동경로
        String moveTo = "";
        
		
		session = request.getSession();
		
		session.setMaxInactiveInterval(60*60);

        //로그인유지 유무
        String keepLogin = (String)session.getAttribute("keepLogin");
        
        //System.out.println(keepLogin);
        		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		//카카오 code값을 이용해 엑세스 토큰 및 통신코드 받기
		HashMap<String,Object> kakaoInfo = userService.getAccessToken(code);
        
        //카카오 통신 코드 200이여야 정상 처리됨
        int responseCode = (int)kakaoInfo.get("responseCode");
    	
    	//통신 코드가 200이 아니면 카카오API 통신 실패
        if(responseCode != 200) {
        	
        	System.out.println("카카오 로그인 오류(code : "+responseCode+")");
        	
        	msg = "alert('카카오 로그인에 실패하였습니다.(오류코드 : kakao"+responseCode+")\\n관리자에게 문의해주세요.');";
        	
        	moveTo = path+"/user/login.do";
        	
        } else {

            //카카오 엑세스 토큰
            String access_Token = (String)kakaoInfo.get("access_Token");
            
        	//엑세스 토큰을 이용하여 카카오 회원정보를 받기
            HashMap<String, Object> userInfo = userService.getKakaoUserInfo(access_Token);
            
            //카카오 회원정보의 이메일 주소
            String kakao_email = (String)userInfo.get("kakao_email");
        	
        	//로그인 정보를 담기위한 UserVO
        	UserVO userLoginInfo = new UserVO();
        	
        	//카카오 회원정보의 이메일과 일치하는 회원정보가 있는지 확인
        	int result = userService.emailChk(kakao_email);
        	
        	//일치하는 정보가 없다면 카카오 회원정보를 이용하여 회원정보를 AnnaUser 테이블에 입력 후 로그인 처리 
        	if(result == 0) {
            	
        		String kakao_nickName = (String)userInfo.get("nickName");
            	
            	String kakaoId = (String)userInfo.get("kakaoId");
            	
            	String thumbnail_image = (String)userInfo.get("thumbnail_image");
            	
                //카카오 회원정보를 담기위한 UserVO
                UserVO kvo = new UserVO();

            	kvo.setUser_email(kakao_email);
            	
            	kvo.setNickName(kakao_nickName);
            	
            	kvo.setKakao_auth(kakaoId);
            	
            	kvo.setProfile_image(thumbnail_image);
        		
            	if(userService.join(kvo) != 1) {
            		
            		System.out.println("카카오 회원정보 입력 오류");
            		
            		msg = "alert('오류가 발생하였습니다.(오류코드 : join)\\n관리자에게 문의해주세요.');";
                	
                	moveTo = path+"/user/login.do";
            		
            	} else {
            		
            		System.out.println("카카오 로그인 처리");

            		userLoginInfo.setUser_email(kakao_email);
            		
            		userLoginInfo = userService.login(userLoginInfo);
            		
        			moveTo = path+"/main.do";
        			
            	}
            	
        	} else {	//일치하는 정보가 있다면 kakao_auth update 후 로그인 처리
        		
        		System.out.println("가입된 이메일 주소 카카오 id(kakao_auth) update 후 로그인 처리");
        		
        		userLoginInfo.setUser_email(kakao_email);
        		
        		userLoginInfo = userService.login(userLoginInfo);
        		
        		if(userLoginInfo.getKakao_auth() == "") {
        			
        			userLoginInfo.setKakao_auth(userLoginInfo.getKakao_auth());
        			
        			userService.updateKakaoAuthKey(userLoginInfo);
        			
        		}
    			
    			moveTo = path+"/user/myPage.do";
        			
        	}
        	
        	//로그인 유지체크를 한경우 쿠키를생성한다.
        	if(keepLogin.equals("true")) {
        		Cookie cookie = new Cookie("uidx",Integer.toString(userLoginInfo.getUidx()));
        		cookie.setPath("/");
        		cookie.setMaxAge(60*60*24*7);//쿠키유지 일주일
        		response.addCookie(cookie);
        	}
    		
			//로그인 세션정보 (회원번호, 이메일[아이디], 닉네임)
        	session.setAttribute("userLoginInfo", userLoginInfo);
        	
			session.setAttribute("uidx", userLoginInfo.getUidx());
			
			session.setAttribute("access_Token", access_Token);
			
			
        	
        	
        }
        
        pw.append("<script>"+msg+" location.href='"+moveTo+"';</script>");
		
		pw.flush();
		
		pw.close();
		
	}
	
	//마이 페이지
	@RequestMapping(value="/myPage.do")
	public String myPage(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = 0;
		
		List<BoardItemVO> list = null;
		
		List<BoardVO> blist = null;
		
		uidx = (int)session.getAttribute("uidx");
		
		UserVO uv = (UserVO)session.getAttribute("userLoginInfo");
		
		//System.out.println(uv.getLocation_auth());
		
		UserVO userInfo = userService.getUserInfo(uidx);
		
		if(userInfo.getInterested() != null) {
			String[] ArrayInterested = userInfo.getInterested().split(",");
			List<String> listInterested = new ArrayList<String>();
			
			for(int i = 0; i < ArrayInterested.length; i++) {
				listInterested.add(ArrayInterested[i]);
			}
			
			list = userService.getInterestedItem(listInterested);
			
		}
		
		if(uv.getLocation_auth() != null) {
			blist = userService.myTownCommunityList(uv.getLocation_auth());
		}
		
		System.out.println(blist);

		model.addAttribute("myTownCommunityList",blist);
		
		model.addAttribute("interestedList",list);
		
		model.addAttribute("userInfo",userInfo);
		
		return "user/myPage";
		
	}
	
	//회원정보 조회
	@RequestMapping(value="/userInfoView.do")
	public String userInfo(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = 0;
			
		uidx = (int)session.getAttribute("uidx");
		
		UserVO userInfo = userService.getUserInfo(uidx);
		
		model.addAttribute("userInfo",userInfo);
				
		return "user/userInfoView";
		
	}
	
	
	//회원정보 수정페이지
	@RequestMapping(value="/userInfoMod.do", method=RequestMethod.GET)
	public String userInfoMod(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		if(session.getAttribute("uidx") != null) {		
			
			int uidx = (int)session.getAttribute("uidx");
			
			UserVO userInfo = userService.getUserInfo(uidx);
			
			model.addAttribute("userInfo",userInfo);
			
		} 
		
		return "user/userInfoMod";
		
	}
	
	
	//회원정보 수정 및 조회 페이지로 되돌아가기
	@RequestMapping(value="/userInfoMod.do", method=RequestMethod.POST)
	public String userInfoMod(UserVO vo,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		vo.setUidx(uidx);
		
		int result = userService.userInfoMod(vo);
		
		return "redirect:/user/userInfoView.do";
		
	}
	
	
	//관심 키워드 업데이트
	@ResponseBody
	@RequestMapping(value="/updateKeyword.do", produces="application/test; charset=utf8")
	public String updateKeyword(UserVO vo,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		vo.setUidx(uidx);
		
		int result = userService.updateInterested(vo);
		
		//System.out.println(vo.getInterested());
		
		return result+"";
	}
	
	
	//가입된 이메일인지 확인후 인증 이메일을 보내는 Ajax
	@ResponseBody
	@RequestMapping(value="/emailChk.do", produces = "application/text; charset=utf8")
	public String emailChk(String user_email) {
		
		int result = userService.emailChk(user_email);
		
		return result+"";
		
	}
	
	//이메일 인증 메일 전송
	@ResponseBody
	@RequestMapping(value="/sendAuthEmail.do",produces = "application/text; charset=utf8")
	public String sendAuthEmail(String user_email) {
		
		String authKey = mailService.sendAuthMail(user_email);
		
		return authKey;
		
	}
	
	//동네설정 페이지
	@RequestMapping(value="/locationAuth.do")
	public String locationAuth(Model model) {
		
		model.addAttribute("path",path);
		
		return "user/locationAuth";
		
	}
	
	//동네설정 페이지
	@RequestMapping(value="/locationView.do")
	public String locationAuth(String[] dong,Model model) {
		
		model.addAttribute("path",path);
		
		model.addAttribute("selectedDong",dong);
		
		return "user/locationView";
		
	}
	
	//동네설정 업데이트
	@RequestMapping(value="/updateLocation.do")
	public String locationUpdate(String selectedLocation,HttpServletRequest request,HttpSession session) {
		//System.out.println(selectedLocation);
		String location_auth = selectedLocation;
		
		session = request.getSession();
		
		UserVO vo = new UserVO();
		
		vo.setLocation_auth(location_auth);
		
		vo.setUidx((int)session.getAttribute("uidx"));

		//System.out.println(vo.getLocation_auth());
		
		int result = userService.updateLocation(vo);
		
		return "redirect:/user/userInfoMod.do";
	}
	
	//이웃관리 페이지
	@RequestMapping(value="/neighborMng.do")
	public String neighborMng(String[] dong,Model model,HttpSession session, HttpServletRequest request) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<UserVO> nList = userService.neighborList(uidx);
		
		model.addAttribute("nList",nList);
		
		return "user/neighborMng";
		
	}
}
