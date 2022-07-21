package edu.fourmen.controller;


import java.awt.image.BufferedImage;
import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;

import edu.fourmen.service.BoardItemService;
import edu.fourmen.vo.BoardItemVO;

import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;

import edu.fourmen.vo.UserVO;

@RequestMapping(value = "/boarditem")
@Controller
public class BoardItemController {

	@Autowired
	BoardItemService boarditemService;

	@RequestMapping(value = "/itemlist.do")

	public String itemlist(PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {

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
		
	    List<BoardItemVO> list = boarditemService.list(vo,pm);
		
	    
	    model.addAttribute("pm",pm);
	    model.addAttribute("list", list);

		return "boarditem/itemlist";
	}/*
		 * @RequestMapping(value="/ajax_board.do") public String itemlist2(BoardItemVO
		 * vo, PageMaker pm , HttpServletRequest request, Model model) {
		 * 
		 * //한 페이지에 몇개씩 표시할 것인지 int pagecount = 15; //보여줄 페이지의 번호를 일단 1이라고 초기값 지정 int
		 * pagenumber = 1; //페이지 번호가 파라미터로 전달되는지 읽어와본다. String strPageNum =
		 * request.getParameter("pagenumber"); //만일 페이지 번호가 파리미터로 넘어온다면 if(strPageNum !=
		 * null) { //숫자로 바꿔서 보여줄 페이지 번호를 지정한다. pagenumber =
		 * Integer.parseInt(strPageNum); }
		 * 
		 * //보여줄 페이지의 시작 ROWNUM - 0부터 시작 int startPage = 1+ (pagenumber - 1)* pagecount;
		 * //보여줄 페이지의 끝 ROWNUM int endPage = pagenumber*pagecount;
		 * 
		 * int pageNum = pagecount;
		 * 
		 * // 검색 키워드 관련된 처리 - 검색 키워드가 넘어올 수 도 있고 안 넘어올 수도 있다.
		 * 
		 * 
		 * 
		 * // 설정해준 값들을 해당 객체에 담는다. pm.setStartPage(startPage); pm.setEndPage(endPage);
		 * pm.setPageNum(pageNum);
		 * 
		 * //ArrayList 객체의 참조값을 담을 지역변수를 만든다. ArrayList<PageMaker> plist = null; //전체
		 * row의 개수를 담을 지역변수를 미리 만든다. -검색 조건이 들어온 경우 '검색 결과 갯수'가 된다. int totalRow = 0;
		 * 
		 * //글의 개수 totalRow = boarditemService.totalcount(vo);
		 * 
		 * //전체 페이지 갯수 구하기 int totalPageCount = (int)Math.ceil(totalRow /
		 * (double)pagecount);
		 * 
		 * request.setAttribute("plist", plist); request.setAttribute("totalPageCount",
		 * totalPageCount); request.setAttribute("totalRow", totalRow);
		 * request.setAttribute("pagenumber", pagenumber);
		 * 
		 * List<BoardItemVO> list = boarditemService.list(vo);
		 * 
		 * model.addAttribute("svo", svo); model.addAttribute("list",list);
		 * 
		 * return "boarditem/ajax_board"; }
		 */


	@RequestMapping(value = "/ajax_item.do")
	public String itemlist2(PageMaker pm, SearchVO svo,BoardItemVO vo,  HttpServletRequest request, Model model) {
		
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
	public String selectitem(PageMaker pm,SearchVO svo,int item_idx, HttpServletResponse response, HttpServletRequest request,

			HttpSession session, Model model) {
		session = request.getSession();
		UserVO login = (UserVO) session.getAttribute("login");
		model.addAttribute("login", login);

		BoardItemVO vo = boarditemService.selectitem(item_idx);

		
		    List<BoardItemVO> list = boarditemService.list(vo,pm);
		    model.addAttribute("list", list);
		
		    model.addAttribute("vo", vo);
		List<BoardItemVO> list2 = boarditemService.list2(vo,svo);
		model.addAttribute("list2", list2);


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

				// String imgpath = path+uploadFile1.getOriginalFilename();

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
			// BufferedImage newImage = new BufferedImage(newWidth,
			// newHeight,BufferedImage.TYPE_INT_RGB);
			// MultipartFile reimage = (MultipartFile)newImage;
			//
			// fileName = uuid+"_"+reimage.getOriginalFilename();
			// System.out.println(fileName+"리사이즈된 파일네임 입니다.");
			//
			// Graphics graphics = newImage.getGraphics();
			// graphics.drawImage(resizeImage, 0, 0, null);
			// graphics.dispose();
			//
			// vo.setImage1(fileName);

			BufferedImage sourceImg = ImageIO.read(new File(path, fileName));
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
			BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

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
	public String modify(Model model, int item_idx) {
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		
		model.addAttribute("vo",vo);
		
		return "boarditem/itemmodify";
		
	}
	@RequestMapping(value="/itemmodify.do", method=RequestMethod.POST)
	public String modify(BoardItemVO vo) {
			
			int result = boarditemService.itemmodify(vo);
		
		return "redirect:/boarditem/itemlist.do";
		
	}
	

	@RequestMapping(value="/itemdelete.do", method=RequestMethod.GET)
	public String delete(Model model, int item_idx) {
		
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		
		model.addAttribute("vo",vo);
		
		return "boarditem/itemdelete";
	}
	
	@RequestMapping(value="/itemdelete.do", method=RequestMethod.POST)
	public String delete(BoardItemVO vo) {
			
			int result = boarditemService.itemdelete(vo);
		
		return "redirect:/itemboard/itemlist.do";
	}
	

}