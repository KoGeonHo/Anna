package edu.fourmen.controller;


import java.awt.image.BufferedImage;
import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import edu.fourmen.service.AdminService;
import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;

import edu.fourmen.vo.UserVO;

@RequestMapping(value = "/boarditem")
@Controller
public class BoardItemController {
	private List<ChatMessageVO> chatlist;
	@Autowired
	UserService userService;
	
	@Autowired
	BoardItemService boarditemService;
	
	@Autowired
	AdminService adminService;
	String path = "/anna";
	
	
	
	
	@RequestMapping(value = "/itemlist.do")
	public String itemlist(HttpSession session,PageMaker pm,BoardItemVO vo,HttpServletResponse response ,HttpServletRequest request, Model model) throws IOException {
		session = request.getSession();
		if(pm.getSearchVal() == null) {
			pm.setSearchVal("");
		}
		
		
		
		//회원의 지역코드 넘기는 부분
		// 이따 세션에서 뽑아오려면 이 부분 if문도 변경
		if (session.getAttribute("uidx") != null) {
			int uidx = (int) session.getAttribute("uidx");
			UserVO uvo = userService.getUserInfo(uidx);
			pm.setUidx(uidx);
			//내 지역보기 체크
			//session locationSet 으로 변경할것
			String auth = uvo.getLocation_auth();
			pm.setAddr_code(auth);	
			model.addAttribute("addr_code",auth);
	
		//찜 많은순 보기  wishchceck 로 한 이유는 현재 사용되는 value 값이 1,2 밖에 없음. 
		//그 이후로 늘어날 일도 없고 새로운 변수를 선언하기 애매해서 그냥 쓰는중
		if(pm.getWishCheck() == 3) {
			
			pm.setWishCheck(pm.getWishCheck());
			System.out.println("찜 많은순 보기 들어옴");
		}
		//내 키워드 상품 보기
		if(pm.getWishCheck() == 4) {
			
			String keyword = uvo.getInterested();
			pm.setInterested(keyword);
		}
		
		}
		//한 페이지에 몇개씩 표시할 것인지
				int pagecount = 12;
				//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
				int pagenumber = 1;
				//페이지 번호가 파라미터로 전달되는지 읽어와본다.
				String strPageNum = request.getParameter("pagenumber");
				//만일 페이지 번호가 파리미터로 넘어온다면
				if(strPageNum != null) {
					//숫자로 바꿔서 보여줄 페이지 번호를 지정한다.
					pagenumber = Integer.parseInt(strPageNum);
				}
				
				//보여줄 페이지의 시작 ROWNUM - 0부터 시작
				int startPage = 0+ (pagenumber - 1)* pagecount;
				//보여줄 페이지의 끝 ROWNUM
				int endPage = pagenumber*pagecount;
				
				int pageNum = pagecount;
				
				// 검색 키워드 관련된 처리 - 검색 키워드가 넘어올 수 도 있고 안 넘어올 수도 있다.

				// 설정해준 값들을 해당 객체에 담는다.
				pm.setStartPage(startPage);
				pm.setEndPage(endPage);
				pm.setPageNum(pageNum);
				
				//ArrayList 객체의 참조값을 담을 지역변수를 만든다.
				ArrayList<PageMaker> plist = null;
				//전체 row의 개수를 담을 지역변수를 미리 만든다. -검색 조건이 들어온 경우 '검색 결과 갯수'가 된다.
				int totalRow = 0;

				//글의 개수
				totalRow = boarditemService.totalCount(pm);
				
				//전체 페이지 갯수 구하기
				int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
				
				request.setAttribute("plist", plist);
				request.setAttribute("totalPageCount", totalPageCount);
				request.setAttribute("totalRow", totalRow);
				request.setAttribute("pagenumber", pagenumber);
		
		
		
		//전체 상품 리스트 받아오기
	    List<BoardItemVO> list = boarditemService.list(pm);
	    
	    
	    //최저가 상품 정보 받아오기
	    List<BoardItemVO> ssang = boarditemService.MinPrice(pm);
	    
	    model.addAttribute("ssang",ssang);
	    model.addAttribute("pm",pm);
	    model.addAttribute("list", list);
	    
	    
	    
		
		
	    
		//리스트에서 볼때 각각의 글 공간 안에 찜 수 넣으려고 만듬
		
		return "boarditem/itemlist";
	}

	@ResponseBody
	@RequestMapping(value = "/ajax_main.do", produces = "application/json; charset=utf8")
	   public HashMap<String, Object> main2(HttpSession session,PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {
		
		session = request.getSession();
		
		
	
		
		if(pm.getSearchVal() == null) {
			pm.setSearchVal("");
		}
	      
	      
	      
	      //한 페이지에 몇개씩 표시할 것인지
	      int pagecount = 12;
	      //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	      int pagenumber = 1;
	      //페이지 번호가 파라미터로 전달되는지 읽어와본다.
	      String strPageNum = request.getParameter("pagenumber");
	      //만일 페이지 번호가 파리미터로 넘어온다면
	      if(strPageNum != null) {
	         //숫자로 바꿔서 보여줄 페이지 번호를 지정한다.
	         pagenumber = Integer.parseInt(strPageNum);
	      }
	      
	      //보여줄 페이지의 시작 ROWNUM - 0부터 시작
	      int startPage = 0+ (pagenumber - 1)* pagecount;
	      //보여줄 페이지의 끝 ROWNUM
	      int endPage = pagenumber*pagecount;
	      
	      int pageNum = pagecount;
	      
	      // 검색 키워드 관련된 처리 - 검색 키워드가 넘어올 수 도 있고 안 넘어올 수도 있다.
	      
	      
	      
	      
	      // 설정해준 값들을 해당 객체에 담는다.
	      pm.setStartPage(startPage);
	      pm.setEndPage(endPage);
	      pm.setPageNum(pageNum);
	      
	      
	      //ArrayList 객체의 참조값을 담을 지역변수를 만든다.
	      ArrayList<PageMaker> plist = null;
	      //전체 row의 개수를 담을 지역변수를 미리 만든다. -검색 조건이 들어온 경우 '검색 결과 갯수'가 된다.
	      int totalRow = 0;
	      
	      //글의 개수
	      totalRow = boarditemService.totalCount(pm);
	      
	      //전체 페이지 갯수 구하기
	      int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
	      request.setAttribute("plist", plist);
	      request.setAttribute("totalPageCount", totalPageCount);
	      request.setAttribute("totalRow", totalRow);
	      request.setAttribute("pagenumber", pagenumber);
	      
	      
	      int uidx = (int) session.getAttribute("uidx");
	      
	      pm.setUidx(uidx);
	     
	      List<BoardItemVO> list = boarditemService.list(pm);
	      
	      HashMap<String, Object> result = new HashMap<String,Object>();

	      result.put("appendList", list);
	      
	      return result;
	   }
	
	@ResponseBody
	@RequestMapping("/addviewcount")
	public int addviewcount(BoardItemVO vo) {
		int item_idx = vo.getItem_idx();
		vo.setItem_idx(item_idx);
		boarditemService.addviewCount(item_idx);
		return 1;
	}

	
	@RequestMapping(value = "itemview.do")
	public String selectitem(BoardItemVO wvo,BoardItemVO bvo,ChatMessageVO cvo,PageMaker pm,SearchVO svo,int item_idx, HttpServletResponse response, HttpServletRequest request,
			HttpSession session, Model model) throws ParseException {
		

		session = request.getSession();
		
		if(session.getAttribute("uidx") != null) {
		int uidx = (int) session.getAttribute("uidx");
		}
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo", vo);
		
		//끌올 시작
		SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		//캘린더 클래스로 현재 시간 불러온 부분
		
		//끌올버튼 기간제한 부분
		Date now = new Date();//현재 시간 추출
		cal.setTime(now); //현재 시간 캘린더에 넣음
		String nowtime = df.format(cal.getTime()); // 영문으로 출력되는걸 타입 변환을 이용해서 잘랐음
		Date realnowtime = df.parse(nowtime); // 잘라놓은 날짜를 다시 데이트 타입으로 전환
		
		String wwdate = vo.getWdate();  //작성된 글의 시간을 추출해서 넣기
		Date date = df.parse(wwdate); // 추출해서 넣은 작성시간을 Date 타입으로 변경
		
		cal.setTime(date); // 캘린더 함수에 추가
		
		/*
		 * cal.add(Calendar.MONTH, 1);// 캘린더 함수를 통해 넣은 시간에 1달을 더함
		 * System.out.println("한달 후"+ df.format(cal.getTime())); // 더해진 시간 확인
		 * 
		 * String updatewdate = df.format(cal.getTime()); // 1달이 더해진 시간을 string 타입에 넣음
		 * Date wdate = df.parse(updatewdate);// string 타입을 date 타입으로 전환
		 */		
		
		int Sec = (int) ((realnowtime.getTime() - date.getTime()) / 1000); //두 날짜의 차이를 초 단위로 만듬
		int Days = Sec / (24*60*60) ; // 초 단위로 만든 두 날짜의 차이를 일(하루) 기준으로 만듬
		model.addAttribute("Days", Days); //두 날짜의 차이를 화면으로 보냄
		
		
		//
		
		
		
		
		
		
		
		
		
		List<BoardItemVO> list = boarditemService.list(pm);
		model.addAttribute("list", list);

		
		List<BoardItemVO> youritem = boarditemService.selectAllbyuser(vo, svo);
		model.addAttribute("youritem", youritem);
		
		Cookie cookie = new Cookie ("item_idx", Integer.toString(item_idx)); // 쿠키에 "키값",값 넣기
		cookie.setPath("/");//쿠키의 유효한 디렉토리를 설정하는것 + 모든 경로에서 접근하게 하는것
		cookie.setMaxAge(60*60*24*7);//일주일간 쿠키 유지
		response.addCookie(cookie);//쿠키에 추가
		
		
		
		//이웃체크
		if(session.getAttribute("uidx") != null) {
		int neighbor_idx = vo.getUidx();
		int uidx = (int) session.getAttribute("uidx");
		bvo.setNeighbor_idx(neighbor_idx);
		bvo.setUidx(uidx); //이게 있으면 추가가 안되고 없으면 체크가 안된다.
		}
		int result = boarditemService.neighbor_check(bvo);
		model.addAttribute("result",result);
		System.out.println(result +"이웃 체크");
		
		
		//찜 체크
		if(session.getAttribute("uidx") != null) {
			int W_item_idx = vo.getItem_idx();
			int uidx = (int) session.getAttribute("uidx");
			wvo.setItem_idx(W_item_idx);
			wvo.setUidx(uidx);
		}
		
		int wish = boarditemService.checkWish(wvo);
		model.addAttribute("wish",wish);
		int wishCount = boarditemService.WishCount(item_idx);
		model.addAttribute("wishCount",wishCount);
	
		int viewCount = boarditemService.viewCount(vo);
		model.addAttribute("viewCount",viewCount);
		
		
		
		return "boarditem/itemview";

	}

	@RequestMapping(value = "itemwrite.do", method = RequestMethod.GET)
	public String itemwrite() {

		return "boarditem/itemwrite";
	}

	@RequestMapping(value = "itemwrite.do", method = RequestMethod.POST)
	public String itemwrite(BoardItemVO vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) throws IllegalStateException, IOException {
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		String fileName = null;

		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);

		
		
		if (vo.getFile1() != null) {
			MultipartFile uploadFile1 = vo.getFile1();
			String originalFileName = uploadFile1.getOriginalFilename();
//			String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if (!uploadFile1.isEmpty()) {
			fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+originalFileName;
			uploadFile1.transferTo(new File(path, fileName));

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage1(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		if (vo.getFile2() != null) {
			MultipartFile uploadFile2 = vo.getFile2();
			String originalFileName = uploadFile2.getOriginalFilename();
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"2"+"_"+originalFileName;
				uploadFile2.transferTo(new File(path, fileName));
			
			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage2(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile3() != null) {
			MultipartFile uploadFile3 = vo.getFile3();
			String originalFileName = uploadFile3.getOriginalFilename();
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"3"+"_"+originalFileName;
				uploadFile3.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage3(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		if (vo.getFile4() != null) {
			MultipartFile uploadFile4 = vo.getFile4();
			String originalFileName = uploadFile4.getOriginalFilename();
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"4"+"_"+originalFileName;
				uploadFile4.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage4(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		if (vo.getFile5() != null) {
			MultipartFile uploadFile5 = vo.getFile5();
			String originalFileName = uploadFile5.getOriginalFilename();
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"5"+"_"+originalFileName;
				uploadFile5.transferTo(new File(path, fileName));
			
			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage5(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}
		}

		if (vo.getFile6() != null) {
			MultipartFile uploadFile6 = vo.getFile6();
			String originalFileName = uploadFile6.getOriginalFilename();
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"6"+"_"+originalFileName;
				uploadFile6.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage6(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile7() != null) {
			MultipartFile uploadFile7 = vo.getFile7();
			String originalFileName = uploadFile7.getOriginalFilename();
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"7"+"_"+originalFileName;
				uploadFile7.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage7(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			
			}																						// 이름
		}

		if (vo.getFile8() != null) {
			MultipartFile uploadFile8 = vo.getFile8();
			String originalFileName = uploadFile8.getOriginalFilename();
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"8"+"_"+originalFileName;
				uploadFile8.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage8(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile9() != null) {
			MultipartFile uploadFile9 = vo.getFile9();
			String originalFileName = uploadFile9.getOriginalFilename();
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"9"+"_"+originalFileName;
				uploadFile9.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage9(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile10() != null) {
			MultipartFile uploadFile10 = vo.getFile10();
			String originalFileName = uploadFile10.getOriginalFilename();
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"10"+"_"+originalFileName;
				uploadFile10.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage10(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		/*
		 * File dir = new File(path); // path가 존재하는지 여부 확인 if(!dir.exists()) {
		 * dir.mkdirs(); // 위치가 존재하지 않는 경우 위치 생성 }
		 */

		/*
		 * vo.getImage1().getOriginalFilename(); vo.getImage2().getOriginalFilename();
		 * // vo.getImage3().getOriginalFilename();
		 */

		session = request.getSession();
		
		if(vo.getKeyword() != null) {
		 String str = vo.getKeyword().replace(",","#");
		 
		 vo.setKeyword(str);
		}
			/* vo.setKeyword("#"+s); */
		
		//  List<String> list2 = "#"; System.out.println("#"+list2);
		// System.out.println(list2 + "키워드 리스트2222 자르고난후");
		 
		
		// vo.setMidx(login.getMidx());

		 boarditemService.boarditemswrite(vo);

		model.addAttribute("vo", vo);

		response.setContentType("text/html;charset=utf-8");

		
		
		
		return "redirect:/boarditem/itemlist.do" ;
	}
	

	@RequestMapping(value="/itemmodify.do", method=RequestMethod.GET)
	public String modify(HttpSession session,Model model, int item_idx) {
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo",vo);
		
		return "boarditem/itemmodify";
		
	}
	@RequestMapping(value="/itemmodify.do", method=RequestMethod.POST)
	public String modify(int item_idx,BoardItemVO vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, MultipartFile file) throws IllegalStateException, IOException {
			
		
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		String fileName = null;
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		

		if (vo.getFile1() != null) {
			MultipartFile uploadFile1 = vo.getFile1();
			String originalFileName = uploadFile1.getOriginalFilename();
//			String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if (!uploadFile1.isEmpty()) {
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+originalFileName;
				uploadFile1.transferTo(new File(path, fileName));

				System.out.println(uploadFile1.getOriginalFilename() + "두번째 if문 파일네임 입니다.");
		

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage1(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																					// 이름
		}

		if (vo.getFile2() != null) {
			MultipartFile uploadFile2 = vo.getFile2();
			String originalFileName = uploadFile2.getOriginalFilename();
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"2"+"_"+originalFileName;
				uploadFile2.transferTo(new File(path, fileName));
			
			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage2(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile3() != null) {
			MultipartFile uploadFile3 = vo.getFile3();
			String originalFileName = uploadFile3.getOriginalFilename();
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"3"+"_"+originalFileName;
				uploadFile3.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage3(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		if (vo.getFile4() != null) {
			MultipartFile uploadFile4 = vo.getFile4();
			String originalFileName = uploadFile4.getOriginalFilename();
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"4"+"_"+originalFileName;
				uploadFile4.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage4(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																						// 이름
		}

		if (vo.getFile5() != null) {
			MultipartFile uploadFile5 = vo.getFile5();
			String originalFileName = uploadFile5.getOriginalFilename();
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"5"+"_"+originalFileName;
				uploadFile5.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage5(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																					// 이름
		}

		if (vo.getFile6() != null) {
			MultipartFile uploadFile6 = vo.getFile6();
			String originalFileName = uploadFile6.getOriginalFilename();
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"6"+"_"+originalFileName;
				uploadFile6.transferTo(new File(path, fileName));
		

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage6(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																					// 이름

		}

		if (vo.getFile7() != null) {
			MultipartFile uploadFile7 = vo.getFile7();
			String originalFileName = uploadFile7.getOriginalFilename();
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"7"+"_"+originalFileName;
				uploadFile7.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage7(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																					// 이름
		}

		if (vo.getFile8() != null) {
			MultipartFile uploadFile8 = vo.getFile8();
			String originalFileName = uploadFile8.getOriginalFilename();
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"8"+"_"+originalFileName;
				uploadFile8.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage8(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile9() != null) {
			MultipartFile uploadFile9 = vo.getFile9();
			String originalFileName = uploadFile9.getOriginalFilename();
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"9"+"_"+originalFileName;
				uploadFile9.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			// System.out.println("thumbnailName"+thumbnailName);

			File newFile = new File(thumbnailName);
			// System.out.println("newFile:"+newFile);
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// System.out.println("destImg"+destImg);
			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage9(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
			}
		}

		if (vo.getFile10() != null) {
			MultipartFile uploadFile10 = vo.getFile10();
			String originalFileName = uploadFile10.getOriginalFilename();
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"10"+"_"+originalFileName;
				uploadFile10.transferTo(new File(path, fileName));
			

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage10(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
			}																					// 이름
		}
		
		
			boarditemService.itemmodify(vo);
			
		return "redirect:/boarditem/itemview.do?item_idx="+vo.getItem_idx();
		
	}
	
	@ResponseBody
	@RequestMapping("/itemdelete")
	public String delete(HttpSession session,Model model, int item_idx) {

		boarditemService.itemdelete(item_idx);
		System.out.println("게시글 삭제 완료");
		
		return "redirect:/boarditem/itemlist.do";
	}
	
	/*
	 * @RequestMapping(value="/itemdelete.do", method=RequestMethod.POST) public
	 * String delete(HttpSession session,BoardItemVO vo) {
	 * 
	 * 
	 * return "redirect:/itemboard/itemlist.do"; }
	 */
	

	@RequestMapping("/AddMessage")
	@ResponseBody
	public String AddMessage(ChatMessageVO cvo ,HttpServletRequest request, HttpSession session) {
		System.out.println("이쯤에");
		session = request.getSession();
		
		boarditemService.insertChat(cvo);
		System.out.println("거래완료 채팅 보냄");
		
		
		return "" ;
	}
	@RequestMapping("/getAllMessages")
	@ResponseBody
	public String getAllMessages(ChatMessageVO cvo,String nickName,int uidx,int item_idx,String cdate, String contents, HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {

		UserVO userinfo = (UserVO)session.getAttribute("login");
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		int invited = userinfo.getUidx();
		int chat_host = vo.getUidx();
		session.setAttribute("userinfo",userinfo);
		model.addAttribute("vo",vo);
		
		return "d";
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
			
			BoardItemVO itemVO = boarditemService.selectitem(cmvo.getItem_idx());
			
			UserVO hostInfo = userService.getUserInfo(cmvo.getChat_host());
			
			//System.out.println(cmvo.getItem_idx());
			
			model.addAttribute("itemVO",itemVO);
			
			model.addAttribute("hostInfo",hostInfo);
			
			model.addAttribute("audience",audience);
			
			model.addAttribute("path",path);
			
			model.addAttribute("chatViewList",chatViewList);
			
			return "user/chatView";
		}
	
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
	
	@RequestMapping("/clear")
	@ResponseBody
	public String clear() {
		chatlist.clear();
		return "메시지 전체 삭제";
	}
	
	@RequestMapping("/mychatlist")
	@ResponseBody
	public List<ChatMessageVO> mychatlist(int chat_host,ChatMessageVO cvo,HttpSession session,HttpServletRequest request) {
		session = request.getSession();
		
		
		
		cvo.setChat_host(chat_host);
		
		List<ChatMessageVO> mychatlist = boarditemService.mychatlist(cvo);
		return mychatlist;
	}
	
	@RequestMapping("/mychat")
	@ResponseBody
	public List mychat(int chat_host,ChatMessageVO cvo,HttpSession session,HttpServletRequest request) {
		System.out.println("거래채팅창 열었다");
		session = request.getSession();
		
		
		List<ChatMessageVO> mychat = boarditemService.mychat(cvo);
		return mychat;
	}
/*
	@ResponseBody
	@RequestMapping("/neighbor_check")
	public String neighbor_check(HttpSession session, int item_idx, int neighbor_idx, BoardItemVO vo, Model model) {

		

		int result = boarditemService.neighbor_check(vo);

		System.out.println(result + "친구 유무");

		model.addAttribute("result", result);

		if (result == 0) {

			return "/addNeighbor";
		} else {

			return "/delNeighbor";
		}
	}
	 */
		
		
		
		
		
	
	
	@ResponseBody
	@RequestMapping("/addNeighbor")
	public String addNeighbor(HttpSession
			session,HttpServletRequest request ,int item_idx, int neighbor_idx,BoardItemVO vo, Model model) {
		session = request.getSession();
		int uidx = (int) session.getAttribute("uidx");
		
		boarditemService.addNeighbor(vo);
		
		return "이웃추가 완료";
	}
	
	@ResponseBody
	@RequestMapping("/delNeighbor")
	public String delNeighbor(HttpServletRequest request,HttpSession session, int neighbor_idx) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		System.out.println(uidx +"uidxuidx");
		System.out.println(neighbor_idx+"neighbor_idx");
		boarditemService.delneighbor(neighbor_idx, uidx);
		System.out.println("이웃삭제 완료");
		
		return "이웃삭제 완료";

	}
	
	@ResponseBody
	@RequestMapping("/addWish")
	public int addWish(BoardItemVO vo) {
		
		boarditemService.addWish(vo);
		System.out.println("찜 완료");
		return 1;
	}
	
	@ResponseBody
	@RequestMapping("/delWish")
	public int delWish(BoardItemVO vo) {
		
		boarditemService.delWish(vo);
		System.out.println("찜 삭제 완료");
		return 1;
	}
	
	@ResponseBody
	@RequestMapping("/updatestate")
	public int updatestate(int state, int item_idx) {
		
		boarditemService.update_state(state, item_idx);
		System.out.println("거래상태 업데이트 완료");
		
		
		
		
		
		
		
		return 1;
	}
	
	@ResponseBody
	@RequestMapping("/updatewdate")
	public int updatewdate(int item_idx){
		
		/*
		 * BoardItemVO result = boarditemService.selectitem(item_idx);
		 * System.out.println(result.getWdate()+"글 작성날짜"); SimpleDateFormat df= new
		 * SimpleDateFormat("yyyy-MM-dd"); Calendar cal = Calendar.getInstance();
		 * 
		 * String wwdate = result.getWdate(); //작성된 글의 시간을 추출해서 넣기 Date date =
		 * df.parse(wwdate); // 추출해서 넣은 작성시간을 Date 타입으로 변경
		 * 
		 * System.out.println(date +"date"); cal.setTime(date); // 캘린더 함수에 추가
		 * System.out.println("넣은 시간" +df.format(cal.getTime())); // 바로 위에서 넣은 값 확인
		 * 
		 * cal.add(Calendar.MONTH, 1);// 캘린더 함수를 통해 넣은 시간에 1달을 더함
		 * System.out.println("바뀐 시간"+ df.format(cal.getTime())); // 더해진 시간 확인
		 * 
		 * String updatewdate = df.format(cal.getTime()); // 1달이 더해진 시간을 string 타입에 넣음
		 * Date wdate = df.parse(updatewdate);// string 타입을 date 타입으로 전환
		 * 
		 * System.out.println(wdate.getTime() - date.getTime() / 1000 + "두 날짜간의 차이 구하기"
		 * ); int Sec = (int) ((wdate.getTime() - date.getTime()) / 1000); int Days =
		 * Sec / (24*60*60) ; System.out.println("두 날짜의 차이는 =" +Days+"일");
		 */
		boarditemService.update_wdate(item_idx);
		
		
		System.out.println("끌올 완료");
		return 1;
	}
	
	@RequestMapping(value="/report.do")
	public String report_taget(ReportVO rvo,HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
		
		session = request.getSession();
		
		System.out.println("신고하기 들어왔음");
		
		
		
		
	    String fileName =""; 
 	    String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		 
		 
		  if (rvo.getFile1() != null) { MultipartFile uploadFile1 = rvo.getFile1(); //
			 // String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString(); 
				  String originalFileName = uploadFile1.getOriginalFilename();
			  if(!uploadFile1.isEmpty()) { 
					  fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+originalFileName;
					  System.out.println(uploadFile1.getOriginalFilename() + "두번째 if문 파일네임 입니다.");
					  BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
					  BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,
					  Scalr.Mode.FIT_TO_HEIGHT, 450);
					  
					  String thumbnailName = path + File.separator + "s-" + fileName;
					  
					  // System.out.println("thumbnailName"+thumbnailName);
					  
					  File newFile = new File(thumbnailName); //
					  System.out.println("newFile:"+newFile); String formatName =
					  fileName.substring(fileName.lastIndexOf(".") + 1); //
					  System.out.println("destImg"+destImg); boolean flag = ImageIO.write(destImg,
					  formatName.toUpperCase(), newFile); System.out.println("복사여부 flag" + flag);
					  
					  thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
					  rvo.setAttach(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일 // 이름 }
			  }
		  }
		
		
		boarditemService.report_target(rvo);
		System.out.println("신고 완료");
		System.out.println(rvo.getItem_idx()+"신고당한 글 번호");
		return "redirect:/boarditem/itemview.do?item_idx="+rvo.getItem_idx();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}