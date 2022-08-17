package edu.fourmen.controller;


import java.awt.image.BufferedImage;
import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
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
	
	@RequestMapping(value = "/itemlist.do")

	public String itemlist(HttpSession session,BoardItemVO nvo,PageMaker pm,BoardItemVO vo,  HttpServletRequest request, Model model) {
		session = request.getSession();
		
		//블랙리스트 조회
		
		
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
		
		
		System.out.println();
		
		//전체 상품 리스트 받아오기
		int uidx = (int) session.getAttribute("uidx");
		pm.setUidx(uidx);
	    List<BoardItemVO> list = boarditemService.list(vo,pm);
	    
	    
	    
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
	   public HashMap<String, Object> main2(PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {
		
	      if(svo.getSearchType() == null) {
	         svo.setSearchType("TITLE");
	      }
	      if(svo.getSearchVal() == null) {
	         svo.setSearchVal("");
	      }
	      
	      System.out.println();
	      
	      
	      //한 페이지에 몇개씩 표시할 것인지
	      int pagecount = 8;
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
	      
	      
	      
	      
	      List<BoardItemVO> list = boarditemService.list(vo,pm);
	      
	      HashMap<String, Object> result = new HashMap<String,Object>();

	      result.put("appendList", list);
	      
	      return result;
	   }
	    

	
	@RequestMapping(value = "itemview.do")
	public String selectitem(BoardItemVO wvo,BoardItemVO bvo,ChatMessageVO cvo,PageMaker pm,SearchVO svo,int item_idx, HttpServletResponse response, HttpServletRequest request,
			HttpSession session, Model model) {
		

		session = request.getSession();
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo", vo);
		
		
		List<BoardItemVO> list = boarditemService.list(vo,pm);
		model.addAttribute("list", list);

		
		List<BoardItemVO> youritem = boarditemService.selectAllbyuser(vo, svo);
		model.addAttribute("youritem", youritem);
		System.out.println(youritem+"판매자의 다른 상품 리스트");
		
		
		
		//이웃체크
		if(session.getAttribute("uidx") != null) {
		int uidx = (int) session.getAttribute("uidx");
		int neighbor_idx = vo.getUidx();
		bvo.setNeighbor_idx(neighbor_idx);
		bvo.setUidx(uidx); //이게 있으면 추가가 안되고 없으면 체크가 안된다.
		}
		int result = boarditemService.neighbor_check(bvo);
		model.addAttribute("result",result);
		System.out.println(result +"이웃 체크");
		
		
		//찜 체크
		if(session.getAttribute("uidx") != null) {
			int uidx = (int)session.getAttribute("uidx");
			int W_item_idx = vo.getItem_idx();
			wvo.setItem_idx(W_item_idx);
			wvo.setUidx(uidx);
		}
		
		int wish = boarditemService.checkWish(wvo);
		model.addAttribute("wish",wish);
		int wishCount = boarditemService.WishCount(item_idx);
		model.addAttribute("wishCount",wishCount);
		boarditemService.addviewCount(vo);
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
		UUID uuid = UUID.randomUUID();

		if (vo.getFile1() != null) {
			MultipartFile uploadFile1 = vo.getFile1();
//			String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if (!uploadFile1.isEmpty()) {
				fileName = uuid + "_" + uploadFile1.getOriginalFilename();
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
			}																						// 이름
		}

		if (vo.getFile2() != null) {
			MultipartFile uploadFile2 = vo.getFile2();
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile2.getOriginalFilename();
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
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile3.getOriginalFilename();
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
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile4.getOriginalFilename();
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
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile5.getOriginalFilename();
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
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile6.getOriginalFilename();
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
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile7.getOriginalFilename();
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
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile8.getOriginalFilename();
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
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile9.getOriginalFilename();
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
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile10.getOriginalFilename();
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
		
		/*
		 System.out.println(vo.getKeyword()+"맨 처음 받은 키워드");
		 System.out.println(vo.getKeyword().split(",")+"두번째 받은 키워드");
		 
		 String[] str = vo.getKeyword().split(",");
		 String asd = "";
		 for(String s : str) {
			 	asd += "#"+s;
				System.out.println(asd);
		 }
		 vo.setKeyword(""+asd+"");
		 
			/* vo.setKeyword("#"+s); */
		/*
		 * List<String> list2 = "#"+s ; System.out.println("#"+list2);
		 * System.out.println(list2 + "키워드 리스트2222 자르고난후");
		 */
		
		// vo.setMidx(login.getMidx());

		 boarditemService.boarditemswrite(vo);

		model.addAttribute("vo", vo);

		response.setContentType("text/html;charset=utf-8");

		
		
		
		return "redirect:/boarditem/itemlist.do" ;
	}
	

	@RequestMapping(value="/itemmodify.do", method=RequestMethod.GET)
	public String modify(HttpSession session,Model model, int item_idx) {
		UserVO userinfo = (UserVO) session.getAttribute("login");
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		
		model.addAttribute("userinfo",userinfo);
		model.addAttribute("vo",vo);
		
		return "boarditem/itemmodify";
		
	}
	@RequestMapping(value="/itemmodify.do", method=RequestMethod.POST)
	public String modify(int item_idx,BoardItemVO vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, MultipartFile file) throws IllegalStateException, IOException {
			
		
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);

		String fileName = null;
		UUID uuid = UUID.randomUUID();
		// System.out.println(vo.getFile1().getOriginalFilename()+"파일1");

		if (vo.getFile1() != null) {
			MultipartFile uploadFile1 = vo.getFile1();
//			String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if (!uploadFile1.isEmpty()) {
				fileName = uuid + "_" + uploadFile1.getOriginalFilename();
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
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile2.getOriginalFilename();
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
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile3.getOriginalFilename();
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
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile4.getOriginalFilename();
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
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile5.getOriginalFilename();
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
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile6.getOriginalFilename();
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
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile7.getOriginalFilename();
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
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile8.getOriginalFilename();
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
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile9.getOriginalFilename();
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
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile10.getOriginalFilename();
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
	@RequestMapping(value="/itemdelete.do", method=RequestMethod.GET)
	public String delete(HttpSession session,Model model, int item_idx,BoardItemVO vo) {

		int result = boarditemService.itemdelete(vo);
		System.out.println("게시글 삭제 완료");
		
		return "boarditem/itemlist";
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
	public Map AddMessage(BoardItemVO vo ,ChatMessageVO cvo,String nickName, String cdate,  String contents, HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("이쯤에");
		session = request.getSession();
		
		int invited = (int) session.getAttribute("uidx"); //세션의 uidx값을 invited 에 넣음
		
		int result = boarditemService.insertChat(cvo);
		
		boarditemService.selectChat(cvo);
		//ajax가 가져갈 출력값 개체 생성
		Map rs = new HashMap<String, Object>();
		
		return rs;
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
	
	
	
	@RequestMapping("/getMessages")
	@ResponseBody
	public List<ChatMessageVO> getMessages(BoardItemVO vo,int from,ChatMessageVO cvo,HttpSession session,Model model) {
		
		int chat_read = 0;
		
		String nickName = (String)session.getAttribute("nickName");
		int invited = (int) session.getAttribute("uidx");
		int chat_host = vo.getChat_host();
		int item_idx = vo.getItem_idx();
		cvo.setNickName(nickName);
		cvo.setChat_host(chat_host);
		cvo.setInvited(invited);
		cvo.setItem_idx(item_idx);
		List<ChatMessageVO> chatlist = boarditemService.selectChat(cvo);
		return chatlist;
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
	
	@RequestMapping(value="/report.do")
	public String report_taget(ReportVO rvo,HttpServletRequest request) throws IllegalStateException, IOException {
		
		System.out.println("신고하기 들어왔음");
		
		  UUID uuid = UUID.randomUUID(); 
		  String fileName =""; 
		  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		 System.out.println(rvo.getFile1()+"신고하기 파일확인");
		
		  if (rvo.getFile1() != null) { MultipartFile uploadFile1 = rvo.getFile1(); //
			 // String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString(); 
			  if(!uploadFile1.isEmpty()) { 
				 fileName = uuid + "_" +uploadFile1.getOriginalFilename(); uploadFile1.transferTo(new File(path,fileName));
				 System.out.println(uploadFile1.getOriginalFilename() + "두번째 if문 파일네임 입니다.");
				  }
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
		
		
		boarditemService.report_target(rvo);
		System.out.println("신고 완료");
		System.out.println(rvo.getItem_idx()+"신고당한 글 번호");
		return "redirect:/boarditem/itemview.do?item_idx="+rvo.getItem_idx();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}