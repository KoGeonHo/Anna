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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;

import edu.fourmen.vo.UserVO;

@RequestMapping(value = "/boarditem")
@Controller
public class BoardItemController {
	private List<ChatMessageVO> messages;
	@Autowired
	UserService userService;
	
	@Autowired
	BoardItemService boarditemService;

	@RequestMapping(value = "/itemlist.do")

	public String itemlist(HttpSession session,PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {

		if(svo.getSearchType() == null) {
			svo.setSearchType("TITLE");
		}
		if(svo.getSearchVal() == null) {
			svo.setSearchVal("");
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
		
		
		
		System.out.println(vo.getCate_idx()+"카테고리선택");
		
		//전체 상품 리스트 받아오기
	    List<BoardItemVO> list = boarditemService.list(vo,pm);
	    //최저가 상품 정보 받아오기
	    

	    BoardItemVO ssang = boarditemService.MinPrice(pm);
	    

	    model.addAttribute("ssang",ssang);
	    model.addAttribute("pm",pm);
	    model.addAttribute("list", list);

		return "boarditem/itemlist";
	}


	@RequestMapping(value = "/ajax_item.do")
	public String itemlist2(HttpSession session,PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {
		
		if(svo.getSearchType() == null) {
			svo.setSearchType("TITLE");
		}
		if(svo.getSearchVal() == null) {
			svo.setSearchVal("");
		}
		
		System.out.println();
		
		
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
		
		
		
		System.out.println(vo.getCate_idx()+"카테고리선택");
		
		List<BoardItemVO> list = boarditemService.list(vo,pm);
		
		
		model.addAttribute("pm",pm);
		model.addAttribute("list", list);
		return "boarditem/ajax_item";
	}

	@RequestMapping(value = "itemview.do")
<<<<<<< HEAD
	public String selectitem(ChatMessageVO cvo,PageMaker pm,SearchVO svo,int item_idx, HttpServletResponse response, HttpServletRequest request,
=======

	public String selectitem(BoardItemVO bvo,ChatMessageVO cvo,PageMaker pm,SearchVO svo,int item_idx, HttpServletResponse response, HttpServletRequest request,
>>>>>>> 3f13b20f8bc4c1ec7328c158d4402a73f6d79878
			HttpSession session, Model model ) {
		
		

		session = request.getSession();
		
		UserVO userinfo = (UserVO) session.getAttribute("login");
		model.addAttribute("userinfo", userinfo);
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo", vo);
		

		
		/*
		 * System.out.println("여기가 문제인가"); List<ChatMessageVO> cv =
		 * boarditemService.selectChat(cvo); model.addAttribute("cv",cv);
		 * System.out.println("여기가 문제인가?????");
		 */
		
		
		
		List<BoardItemVO> list = boarditemService.list(vo,pm);
		model.addAttribute("list", list);

		
		List<BoardItemVO> list2 = boarditemService.selectAllbyuser(vo, svo);
		model.addAttribute("list2", list2);
		
		
<<<<<<< HEAD
		int uidx = (int) session.getAttribute("uidx");
		
		if(session.getAttribute("uidx") != null) {
		int neighbor_idx = vo.getUidx();
		System.out.println(uidx +"session uidx 번호");
		System.out.println(neighbor_idx + "itemview 이웃번호");
		vo.setNeighbor_idx(neighbor_idx);
		vo.setUidx(uidx); //이게 있으면 추가가 안되고 없으면 체크가 안된다.
		
		}
		int result = boarditemService.neighbor_check(vo);
		model.addAttribute("result",result);
		System.out.println(result +"이웃 체크");
		
=======

>>>>>>> 3f13b20f8bc4c1ec7328c158d4402a73f6d79878
		return "boarditem/itemview";

	}

	@RequestMapping(value = "itemwrite.do", method = RequestMethod.GET)
	public String itemwrite() {

		return "boarditem/itemwrite";
	}

	@RequestMapping(value = "itemwrite.do", method = RequestMethod.POST)
	public String itemwrite(BoardItemVO vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, MultipartFile file) throws IllegalStateException, IOException {

		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		UserVO userinfo = (UserVO) session.getAttribute("login");
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
			}
			// BufferedImage inputImage = ImageIO.read(file.getInputStream());
			// int newWidth = 500;
			// int newHeight = 500;// 변경할 가로 길이 int newHeight = 300; // 변경할 세로 길이
			// String option = newWidth+"x"+newHeight;
			// Image image = ImageIO.read(new
			// File(path,uploadFile1.getOriginalFilename()));//원본 이미지 가져오기 // 이미지 품질 설정
			//
			// Image resizeImage = image.getScaledInstance(newWidth, newHeight,
			// Image.SCALE_SMOOTH);
			// FileOutputStream out = new FileOutputStream(path +option+".jpg");
			// ImageIO.write((RenderedImage) resizeImage, "jpg", out);
			
			// //새이미지 저장하기
			// BufferedImage newImage = new BufferedImage(newWidth, newHeight,BufferedImage.TYPE_INT_RGB);
			// MultipartFile reimage = (MultipartFile)newImage;
			//
			// fileName = uuid+"_"+reimage.getOriginalFilename();
			// System.out.println(fileName+"리사이즈된 파일네임 입니다.");
			//
			// Graphics graphics = newImage.getGraphics();
			// graphics.drawImage(resizeImage, 0, 0, null);
			// graphics.dispose();
			//

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
																									// 이름
		}

		if (vo.getFile2() != null) {
			MultipartFile uploadFile2 = vo.getFile2();
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile2.getOriginalFilename();
				uploadFile2.transferTo(new File(path, fileName));
			}
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

		if (vo.getFile3() != null) {
			MultipartFile uploadFile3 = vo.getFile3();
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile3.getOriginalFilename();
				uploadFile3.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile4() != null) {
			MultipartFile uploadFile4 = vo.getFile4();
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile4.getOriginalFilename();
				uploadFile4.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile5() != null) {
			MultipartFile uploadFile5 = vo.getFile5();
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile5.getOriginalFilename();
				uploadFile5.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile6() != null) {
			MultipartFile uploadFile6 = vo.getFile6();
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile6.getOriginalFilename();
				uploadFile6.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile7() != null) {
			MultipartFile uploadFile7 = vo.getFile7();
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile7.getOriginalFilename();
				uploadFile7.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile8() != null) {
			MultipartFile uploadFile8 = vo.getFile8();
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile8.getOriginalFilename();
				uploadFile8.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile9() != null) {
			MultipartFile uploadFile9 = vo.getFile9();
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile9.getOriginalFilename();
				uploadFile9.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile10() != null) {
			MultipartFile uploadFile10 = vo.getFile10();
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile10.getOriginalFilename();
				uploadFile10.transferTo(new File(path, fileName));
			}

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage10(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
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

		UserVO login = (UserVO) session.getAttribute("login");

		// vo.setMidx(login.getMidx());

		int result = boarditemService.boarditemswrite(vo, request);

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
			}
			// BufferedImage inputImage = ImageIO.read(file.getInputStream());
			// int newWidth = 500;
			// int newHeight = 500;// 변경할 가로 길이 int newHeight = 300; // 변경할 세로 길이
			// String option = newWidth+"x"+newHeight;
			// Image image = ImageIO.read(new
			// File(path,uploadFile1.getOriginalFilename()));//원본 이미지 가져오기 // 이미지 품질 설정
			//
			// Image resizeImage = image.getScaledInstance(newWidth, newHeight,
			// Image.SCALE_SMOOTH);
			// FileOutputStream out = new FileOutputStream(path +option+".jpg");
			// ImageIO.write((RenderedImage) resizeImage, "jpg", out);
			
			// //새이미지 저장하기
			// BufferedImage newImage = new BufferedImage(newWidth, newHeight,BufferedImage.TYPE_INT_RGB);
			// MultipartFile reimage = (MultipartFile)newImage;
			//
			// fileName = uuid+"_"+reimage.getOriginalFilename();
			// System.out.println(fileName+"리사이즈된 파일네임 입니다.");
			//
			// Graphics graphics = newImage.getGraphics();
			// graphics.drawImage(resizeImage, 0, 0, null);
			// graphics.dispose();
			//

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
																									// 이름
		}

		if (vo.getFile2() != null) {
			MultipartFile uploadFile2 = vo.getFile2();
			if (!uploadFile2.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile2.getOriginalFilename();
				uploadFile2.transferTo(new File(path, fileName));
			}
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

		if (vo.getFile3() != null) {
			MultipartFile uploadFile3 = vo.getFile3();
			if (!uploadFile3.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile3.getOriginalFilename();
				uploadFile3.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile4() != null) {
			MultipartFile uploadFile4 = vo.getFile4();
			if (!uploadFile4.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile4.getOriginalFilename();
				uploadFile4.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile5() != null) {
			MultipartFile uploadFile5 = vo.getFile5();
			if (!uploadFile5.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile5.getOriginalFilename();
				uploadFile5.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile6() != null) {
			MultipartFile uploadFile6 = vo.getFile6();
			if (!uploadFile6.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile6.getOriginalFilename();
				uploadFile6.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile7() != null) {
			MultipartFile uploadFile7 = vo.getFile7();
			if (!uploadFile7.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile7.getOriginalFilename();
				uploadFile7.transferTo(new File(path, fileName));
			}

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
																									// 이름
		}

		if (vo.getFile8() != null) {
			MultipartFile uploadFile8 = vo.getFile8();
			if (!uploadFile8.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile8.getOriginalFilename();
				uploadFile8.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile9() != null) {
			MultipartFile uploadFile9 = vo.getFile9();
			if (!uploadFile9.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile9.getOriginalFilename();
				uploadFile9.transferTo(new File(path, fileName));
			}

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

		if (vo.getFile10() != null) {
			MultipartFile uploadFile10 = vo.getFile10();
			if (!uploadFile10.isEmpty()) {
				// String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
				fileName = uuid + "_" + uploadFile10.getOriginalFilename();
				uploadFile10.transferTo(new File(path, fileName));
			}

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 450);

			String thumbnailName = path + File.separator + "s-" + fileName;

			File newFile = new File(thumbnailName);

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			boolean flag = ImageIO.write(destImg, formatName.toUpperCase(), newFile);
			System.out.println("복사여부 flag" + flag);

			thumbnailName.substring(path.length()).replace(File.separatorChar, '/');
			vo.setImage10(thumbnailName.substring(path.length()).replace(File.separatorChar, '/')); // 실질적으로 db에 닮기는 파일
																									// 이름
		}

		
		
		
		
			int result = boarditemService.itemmodify(vo);
			
		return "redirect:/boarditem/itemview.do?item_idx="+item_idx;
		
	}
	

	@RequestMapping(value="/itemdelete.do", method=RequestMethod.GET)
	public String delete(HttpSession session,Model model, int item_idx) {
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		
		model.addAttribute("vo",vo);
		
		return "boarditem/itemlist";
	}
	
	@RequestMapping(value="/itemdelete.do", method=RequestMethod.POST)
	public String delete(HttpSession session,BoardItemVO vo) {
			
			System.out.println("게시글 삭제 완료");
			int result = boarditemService.itemdelete(vo);
		
		return "redirect:/itemboard/itemlist.do";
	}
	

	@RequestMapping(value="/chat")
	public String showMain(int item_idx, Model model) {
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo",vo);
		return "boarditem/chat";
	}
	
	BoardItemController(){
		messages = new ArrayList<>();
	}

	@RequestMapping("/AddMessage")
	@ResponseBody
	public Map AddMessage(String nickName,int uidx, String cdate, int item_idx, String contents, HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("이쯤에");
		session = request.getSession();
		UserVO userinfo = (UserVO)session.getAttribute("login");
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		session.setAttribute("userinfo",userinfo);
		model.addAttribute("vo",vo);
		int chat_host = vo.getUidx();
		int invited = (int) session.getAttribute("uidx"); //세션의 uidx값을 invited 에 넣음
		long cidx = messages.size(); // 저장된 마지막 메시지의 다음 번호
		ChatMessageVO chatMessage = new ChatMessageVO(cidx, uidx, invited, contents,chat_host,item_idx,nickName);
		messages.add(chatMessage);
		int result = boarditemService.insertChat(chatMessage);
		
		//ajax가 가져갈 출력값 개체 생성
		Map rs = new HashMap<String, Object>();
		rs.put("chat_host", chat_host);
		rs.put("invited", invited);
		
		return rs;
	}
	@RequestMapping("/getAllMessages")
	@ResponseBody
	public String getAllMessages(ChatMessageVO cvo,String nickName,int uidx,int item_idx,String cdate, String contents, HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {

		UserVO userinfo = (UserVO)session.getAttribute("login");
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		int invited = userinfo.getUidx();
		int chat_host = vo.getUidx();
		 long cidx = messages.size(); // 저장된 마지막 메시지의 다음 번호
		session.setAttribute("userinfo",userinfo);
		model.addAttribute("vo",vo);
		ChatMessageVO chatMessage = new ChatMessageVO(cidx,uidx, invited,contents,chat_host,item_idx,nickName);
		
		return "d";
	}
	
	
	
	@RequestMapping("/getMessages")
	@ResponseBody
	public List getMessages(int from) {
		return messages.subList(from,messages.size());
	}
	
	@RequestMapping("/clear")
	@ResponseBody
	public String clear() {
		messages.clear();
		return "메시지 전체 삭제";
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
			  session,int item_idx, int neighbor_idx,BoardItemVO vo, Model model) {
		System.out.println("이거 여기까진 오기는 하냐");
		int uidx = (int) session.getAttribute("uidx");
		
		System.out.println(neighbor_idx+"이웃 추가쪽 이웃번호");
		System.out.println(uidx+"이웃 추가쪽 세션번호");
		boarditemService.addNeighbor(vo);
		System.out.println("이웃추가 함수가 안됨?");
		
		return "이웃추가 완료";
	}
	
	@ResponseBody
	@RequestMapping("/delNeighbor")
	public String delNeighbor(HttpSession
			 session,int item_idx, int neighbor_idx,BoardItemVO vo, Model model) {
		
		neighbor_idx = vo.getUidx(); //neighbor_idx 안에 글 주인의 uidx를 넣음
		boarditemService.delneighbor(vo);
		System.out.println("이웃삭제 완료");
		return "이웃삭제 완료";

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}