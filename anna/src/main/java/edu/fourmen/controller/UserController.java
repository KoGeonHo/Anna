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
import edu.fourmen.vo.ChatMessageVO;
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
		
		//System.out.println(vo.getKeepLogin());
		
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

					session.setAttribute("uidx", userInfo.getUidx());
					
					//System.out.println("isAdmin? : "+userInfo.getIsAdmin());
					
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
					
					
					if(userInfo.getIsAdmin().equals("Y")) {
						pw.append("<script>location.href='"+request.getContextPath()+"/admin/admin_user.do';</script>");
					}else {
						pw.append("<script>location.href='"+request.getContextPath()+"/main.do';</script>");
					}
					
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
			
			pw.append("<script>alert('환영합니다"+vo.getNickName()+"님, 가입이 완료되었습니다.'); location.href='"+path+"/user/login.do';</script>");
			
			pw.flush();
			
			pw.close();
			
		} else {
			
			pw.append("<script>alert('문제가 발생하여 처리되지 않았습니다.\\n다시 시도해주세요.'); location.href='"+path+"/user/joinS2.do'</script>");
			
			pw.flush();
			
			pw.close();
			
		}
		
	}		
	
	//카카오 인증 Api URL 가져오는 Ajax
	@ResponseBody
	@RequestMapping(value = "/getKakaoAuthUrl.do", produces = "application/text; charset=utf8")
	public String getKakaoAuthUrl(String keepLogin,HttpServletRequest request, HttpSession session) {
		
		/**/
		
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
            
            System.out.println("accessToken:"+access_Token);
            
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
            		
            		String isAdmin = userLoginInfo.getIsAdmin();
            		
            		if(isAdmin.equals("Y")) {
            			moveTo = path+"/admin/admin_user.do";
            		}else {
            			moveTo = path+"/main.do";
            		}
        			
            	}
            	
        	} else {	//일치하는 정보가 있다면 kakao_auth update 후 로그인 처리
        		
        		System.out.println("가입된 이메일 주소 카카오 id(kakao_auth) update 후 로그인 처리");
        		
        		userLoginInfo.setUser_email(kakao_email);
        		
        		userLoginInfo = userService.login(userLoginInfo);
        		
        		String isAdmin = userLoginInfo.getIsAdmin();

        		
        		if(userLoginInfo.getKakao_auth() == "") {
        			
        			userLoginInfo.setKakao_auth(userLoginInfo.getKakao_auth());
        			
        			userService.updateKakaoAuthKey(userLoginInfo);
        			
        		}

        		//System.out.println(kakao_email);
        		
        		if(isAdmin.equals("Y")) {
        			moveTo = path+"/admin/admin_user.do";
        		}else {
        			moveTo = path+"/main.do";
        		}
        	}
        	//System.out.println(keepLogin);
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
		
		//System.out.println(session.getMaxInactiveInterval());
		
		int uidx = (int)session.getAttribute("uidx");

		List<BoardVO> myTownCommunityList = new ArrayList<BoardVO>();
		
		UserVO uv = (UserVO)session.getAttribute("userLoginInfo");
		
		//System.out.println(uv.getLocation_auth());
		
		UserVO userInfo = userService.getUserInfo(uidx);

		List<String> keyWord = new ArrayList<String>();
		
		String[] ArrayInterested = null; 
		
		if(userInfo.getInterested() != null) {
			ArrayInterested = userInfo.getInterested().split(",");
			for(int i = 0; i < ArrayInterested.length; i++) {
				keyWord.add(ArrayInterested[i]);
			}
		}
		
		List<BoardItemVO> interestedList = userService.getInterestedItem(keyWord,uidx);
			
		List<BoardItemVO> myBoardItemList = userService.myBoardItemList(uidx);
		
		if(uv.getLocation_auth() != null) {
			myTownCommunityList = userService.myTownCommunityList(uv.getLocation_auth());
		}
		
		//System.out.println(blist);
		
		List<BoardVO> myCommunity = userService.getMyCommunity(uidx);
		
		model.addAttribute("myCommunity",myCommunity);

		model.addAttribute("myBoardItemList",myBoardItemList);
		
		model.addAttribute("myTownCommunityList",myTownCommunityList);
		
		model.addAttribute("interestedList",interestedList);
		
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
		
		//System.out.println(user_email);
		
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
	public String neighborMng(Model model,HttpSession session, HttpServletRequest request) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<UserVO> nList = userService.neighborList(uidx);
		
		model.addAttribute("nList",nList);
		
		return "user/neighborMng";
		
	}
	
	
	//찜목록
	@RequestMapping(value="/wishList.do")
	public String wishList(Model model,HttpSession session, HttpServletRequest request) {
		
		session = request.getSession();

		int uidx = (int)session.getAttribute("uidx");
		
		List<BoardItemVO> wishList = userService.getWishList(uidx);
		
		model.addAttribute("wishList",wishList);
		
		model.addAttribute("path",path);
		
		return "user/wishList";
	}
	
	
	
	
	
	
	
	//채팅 리스트
	@RequestMapping(value="/chatList.do")
	public String chatList(Model model,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<ChatMessageVO> chatList = userService.getChatList(uidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("chatList",chatList);
		
		return "user/chatList";
	}
	
	//채팅방
	@RequestMapping(value="/chatView.do")
	public String chatView(ChatMessageVO cmvo,Model model,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<ChatMessageVO> chatViewList = userService.getChatViewList(cmvo);
		
		String audience = "";
		
		if(cmvo.getInvited() == uidx) {
			UserVO audienceInfo = userService.getUserInfo(cmvo.getChat_host());
			audience = audienceInfo.getNickName();
		}else if(cmvo.getChat_host() == uidx) {
			UserVO audienceInfo = userService.getUserInfo(cmvo.getInvited());
			audience = audienceInfo.getNickName();
		}
		
		List<Integer> listForSetRead = new ArrayList<Integer>();
		
		for(ChatMessageVO list : chatViewList) {
			//System.out.println(list.getCidx());
			if(uidx != list.getUidx() && list.getChat_read() == 1) {
				listForSetRead.add((int)list.getCidx());
			}
		}
		
		if(listForSetRead.size() != 0) {
			userService.chatSetRead(listForSetRead);
		}
		
		BoardItemVO itemVO = boardItemService.selectitem(cmvo.getItem_idx());
		
		UserVO hostInfo = userService.getUserInfo(cmvo.getChat_host());
		
		//System.out.println(cmvo.getItem_idx());
		
		model.addAttribute("itemVO",itemVO);
		
		model.addAttribute("hostInfo",hostInfo);
		
		model.addAttribute("audience",audience);
		
		model.addAttribute("path",path);
		
		model.addAttribute("chatViewList",chatViewList);
		
		return "user/chatView";
	}
	
	//채팅 메세지 전송
	@ResponseBody
	@RequestMapping(value="/sendMessage.do", produces = "application/json; charset=utf8")
	public String sendMessage(ChatMessageVO cmvo){
		
		int result = boardItemService.insertChat(cmvo);
		
		return result+"";
	}
	
	//채팅 메세지 받기
	@ResponseBody
	@RequestMapping(value="/getMessage.do", produces = "application/json; charset=utf8")
	public ChatMessageVO getMessage(ChatMessageVO cmvo){
		
		ChatMessageVO getMessage = userService.getMessageNoRead(cmvo);
		//System.out.println(getMessage);
		List<Integer> listForSetRead = new ArrayList<Integer>();
		if(getMessage != null) {
			listForSetRead.add((int)getMessage.getCidx());
			userService.chatSetRead(listForSetRead);
		}
		
		return getMessage;
	}
	
	//채팅 목록 새로운 메세지 갱신
	@ResponseBody
	@RequestMapping(value="/checkNewMessage.do",produces = "application/json; charset=utf8")
	public List<ChatMessageVO> checkNewMessage(HttpServletRequest request,HttpSession session){

		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<ChatMessageVO> chatList = userService.getChatList(uidx);
		
		return chatList;
	}
	
	@ResponseBody
	@RequestMapping(value="/passcheck.do",produces = "application/text; charset=utf8")
	public String passchack(String password,HttpServletRequest request,HttpSession session) {
		
		String result = "";
		
		session = request.getSession();
		
		UserVO uv = (UserVO)session.getAttribute("userLoginInfo");
		
		//System.out.println(password);
		
		if(pwdEncoder.matches(password, uv.getUser_pwd())) {
			result = "correct";
		}else {
			result = "incorrect";
		}
		
		//System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value="/changePwd.do",method=RequestMethod.GET)
	public String changePwd(Model model) {
		
		model.addAttribute("path",path);
		
		return "user/changePwd";
		
	}
	
	//비밀번호 변경
	@RequestMapping(value="/changePwd.do",method=RequestMethod.POST)
	public void changePwd(UserVO vo,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {
		
		session = request.getSession();
		
		String user_pwd = vo.getUser_pwd();
		
		int uidx = (int)session.getAttribute("uidx");

		vo.setUser_pwd(pwdEncoder.encode(user_pwd));
		
		vo.setUidx(uidx);
		
		int result = userService.updatePwd(vo);
		
		PrintWriter pw = response.getWriter();
		
		if(result == 1) {
			
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
			
			pw.append("<script>alert('비밀번호변경이 완료되었습니다. 다시 로그인 해주세요!'); location.href='"+path+"/user/login.do'</script>");
			
			pw.flush();
			
			pw.close();
		}
		
	
	}
	
	@RequestMapping(value="/findPwd.do")
	public String findPwd(Model model) {
		
		model.addAttribute("path",path);
		
		return "user/findPwd";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/checkEmailForFindPwd.do",produces = "application/json; charset=utf8")
	public String checkEmailForFindPwd(String user_email) {
		
		return userService.emailChk(user_email)+"";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/sendRandomPwd.do",produces = "application/json; charset=utf8")
	public void sendRandomPwd(UserVO vo) {
		
		String ramdomPwd = mailService.sendPwdMail(vo.getUser_email());
		
		vo.setUser_pwd(pwdEncoder.encode(ramdomPwd));
		
		int result = userService.updateRandomPwd(vo);
		
	}
}
