package edu.fourmen.controller;




import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import java.util.UUID;

import javax.imageio.ImageIO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard(Model model, SearchVO svo, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
		session = request.getSession();
		
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
		totalRow = boardService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		List<BoardVO> freeboard = boardService.selectfreeboard(pm);
		int Ccount = boardService.getCTotal(bv);
		
		bv.setCcount(Ccount);
	
		model.addAttribute("freeboard", freeboard);
		model.addAttribute("svo", svo);
		
		
		
		
		
		

		return "board/FreeBoard";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax_board.do")
	public HashMap<String, Object> ajax_FreeBoard(SearchVO svo, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
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
		totalRow = boardService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		List<BoardVO> board = boardService.selectboard(pm);
		int Ccount = boardService.getCTotal(bv);
		
		bv.setCcount(Ccount);
	
		 HashMap<String, Object> result = new HashMap<String,Object>();

	     result.put("appendList",board);

		

		return result;
	}
	
	@RequestMapping(value="/BoardWrite.do", method= RequestMethod.GET)
	public String BoardWrite(HttpSession session, HttpServletRequest request, UserVO uv) {
		
		session = request.getSession();
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		System.out.println(formatter.format(date));

		return "board/BoardWrite";
	}
	
	@RequestMapping(value="/BoardWrite.do", method = RequestMethod.POST)
	public String BoardWrite(BoardVO vo,HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
		
		session = request.getSession();
		
		// 파일 업로드 처리

		String fileName=null;
		String fileName2=null;
		String fileName3=null;
		String fileName4=null;
		String fileName5=null;
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		
	if(vo.getFileName1() != null) {
		MultipartFile uploadFile = vo.getFileName1();
			//System.out.println(uploadFile);
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+originalFileName;
			//System.out.println(request.getSession().getServletContext().getRealPath("/main/resources/upload/"));
			uploadFile.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
			String oPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName; // 원본 경로
			File oFile = new File(oPath); //파일 클래스를 생성 그 안에 원본 경로를 담는다.

			int index = oPath.lastIndexOf("."); //문자열에서 특정 문자열의 위치 값(index)를 반환한다.
												//indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
												//lastIndexOf는 마지막 문자열의 index를 반환한다.
												// 확장자 찾으려고 "." 위치를 찾는듯하다
			
			String ext2 = oPath.substring(index + 1); // 파일 확장자  //해당 위치부터 해서 확장자 부분을 짜름(?)

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
			System.out.println(tPath+"썸넬 저장경로");
			File tFile = new File(tPath); //파일 클래스를 생성 그 안에 썸네일 저장경로를 담는다.

			//double ratio = 2; // 이미지 축소 비율
			
			try {
				//(int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
				//(int) (oImage.getHeight() / ratio)// 생성할 썸네일이미지의 높이
				BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
				int tWidth =  200;// 생성할 썸네일이미지의 너비
				int tHeight = 200; // 생성할 썸네일이미지의 높이
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제

				ImageIO.write(tImage, ext2, tFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		vo.setImage1(fileName);
	}
	
	if(vo.getFileName2() != null) {
		MultipartFile uploadFile2 = vo.getFileName2();
		if (!uploadFile2.isEmpty()) {
			String originalFileName = uploadFile2.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName2=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"2"+"_"+originalFileName;
			uploadFile2.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName2));
			System.out.println("이미지2저장완료");
		}
		vo.setImage2(fileName2);
	}
	
	if(vo.getFileName3() !=null) {
		MultipartFile uploadFile3 = vo.getFileName3();
		if (!uploadFile3.isEmpty()) {
			String originalFileName = uploadFile3.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName3=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"3"+"_"+originalFileName;
			uploadFile3.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName3));
			System.out.println("이미지3저장완료");
		}
		vo.setImage3(fileName3);
	}
	
	if(vo.getFileName4() !=null) {
		MultipartFile uploadFile4 = vo.getFileName4();
		if (!uploadFile4.isEmpty()) {
			String originalFileName = uploadFile4.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName4=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"4"+"_"+originalFileName;
			uploadFile4.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName4));
		}
		vo.setImage4(fileName4);
	}
	
	if(vo.getFileName5() !=null) {
		MultipartFile uploadFile5 = vo.getFileName5();
		if (!uploadFile5.isEmpty()) {
			String originalFileName = uploadFile5.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName5=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"5"+"_"+originalFileName;
			uploadFile5.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName5));
		}
		vo.setImage5(fileName5);
	}
			boardService.writeBoard(vo);
		
	
		return "redirect:/board/FreeBoard.do"; 	
	}
	


	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int Bidx,Model model, HttpServletRequest request, HttpSession session) {
		
		session = request.getSession();

		BoardVO bv = boardService.viewBoard(Bidx);
		
		BoardVO vo = new BoardVO();
		
		boardService.HitUp(Bidx);
		
		vo.setBidx(Bidx);
		
		if(session.getAttribute("uidx") != null) {
			vo.setUidx(Integer.parseInt(String.valueOf(session.getAttribute("uidx"))));
		}
		model.addAttribute("bv", bv);
		model.addAttribute("like",boardService.Likeyn(vo));
		
		System.out.println("like");
		
		return "board/viewBoard";
	}
	
	

	@ResponseBody
	@RequestMapping(value="/InsertComment",produces = "application/text; charset=utf8")
	public String InsertComment(BoardVO rv, HttpServletRequest request, HttpSession session, int Bidx) {
		
		session = request.getSession();
		//rv.setUidx((int)session.getAttribute("uidx"));
		System.out.println("댓글 등록 통신 성공");
//		if(session.getAttribute("login") == null) {
//			return "fail";
//		} else {
//			System.out.println("로그인함. 스크랩 진행");
			
		System.out.println(rv.getContents()); 
		System.out.println(rv.getNickName()); 
		System.out.println(rv.getBidx()); 
		
			boardService.commentwrite(rv);//댓글작성
			boardService.Ccount(Bidx);
			System.out.println("댓글 등록 서비스 성공");
			return "InsertSuccess";
//		}
	}

	@ResponseBody
	@RequestMapping(value="/CommentList", produces = "application/json; charset=utf8")
	public Map<String, Object> getList(BoardVO rv, Model model) { // @PathVariable: URL 경로에 변수를 넣어주는
		System.out.println("댓글 목록 컨트롤러 동작");
		List<BoardVO> list = boardService.getCList(rv.getBidx());//댓글목록
		int total = boardService.getCTotal(rv); //댓글 갯수
		ModelAndView view = new ModelAndView(); //데이터와 뷰를 동시에 설정이 가능
		System.out.println("댓글 갯수 " + boardService.getCTotal(rv)); //댓글갯수 확인용
		view.setViewName("/board/viewBoard"); //뷰
		Map<String, Object> map = new HashMap<>(); //키와 밸류값으로 저장하는
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}

	
	
	@ResponseBody 
	@RequestMapping(value="/likeUp", method=RequestMethod.POST)
	public void likeup(BoardVO vo, int Bidx, HttpSession session, HttpServletRequest request) {
		System.out.println("컨트롤러 연결 성공");
		
		session = request.getSession();
		
		vo.setBidx(Bidx);
		vo.setUidx((int)session.getAttribute("uidx"));
		
		System.out.println(Bidx);
		System.out.println((int)session.getAttribute("uidx"));

		boardService.boardLikeUP(vo);
	
	}
	
	@ResponseBody
	@RequestMapping(value="/likeDown", method=RequestMethod.POST)
	public void likeDown(BoardVO vo, int Bidx, HttpSession session, HttpServletRequest request) {
		
		session = request.getSession();
		
		System.out.println("좋아요 취소!");
		
		vo.setBidx(Bidx);
		vo.setUidx((int)session.getAttribute("uidx"));
		
		System.out.println(Bidx);
		System.out.println((int)session.getAttribute("uidx"));
		boardService.boardLikeDown(vo);
	}


	
	@RequestMapping(value="/BoardDelete.do")
	public String BoardDelete(int Bidx,BoardVO vo) {
		
		vo.setBidx(Bidx);
		System.out.println("Bidx");
		
		boardService.boardDelete(Bidx);
		System.out.println("삭제완료");
		
		return "redirect:/board/boardlist.do";
	}
	
	@RequestMapping(value="/BoardModify.do", method=RequestMethod.GET)
	public String BoardModify(int Bidx, Model model) {
		
		BoardVO bv = boardService.viewBoard(Bidx);
		model.addAttribute("bv", bv);
		
		
		
		return "board/BoardModify";
	}
	
	@RequestMapping(value="/BoardModify.do", method=RequestMethod.POST)
	public String BoardModify(BoardVO vo, HttpServletRequest request, HttpSession session) throws IOException {
		
		session = request.getSession();
		boardService.boardModify(vo);
		System.out.println("수정됨");
		System.out.println(vo.getBidx()+"bidx");
		return "redirect:/board/boardlist.do?board_type=free"; //redirect://board/boardlist.do
	}
	
	@RequestMapping(value="/test.do")
	public String test(int Bidx,Model model, HttpServletRequest request, HttpSession session) {
				
		model.addAttribute("path","/anna");
		
		session = request.getSession();
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		BoardVO vo = new BoardVO();
		
		boardService.HitUp(Bidx);
		
		vo.setBidx(Bidx);
		if(session.getAttribute("uidx") != null) {
			vo.setUidx(Integer.parseInt(String.valueOf(session.getAttribute("uidx"))));
		}
		model.addAttribute("bv", bv);
		model.addAttribute("like",boardService.Likeyn(vo));
		
		System.out.println("like");
		
		return "board/test";
	}
	
	@RequestMapping(value="/boardlist.do") //게시판 통합
	public String boardlist(Model model, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
		System.out.println(pm.getSearchUidx());
		
		String boardtype = "free";
		
		session = request.getSession();
		if(pm.getBoard_type().equals(boardtype)) {
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
		totalRow = boardService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		
		
		}else if(!pm.getBoard_type().equals(boardtype)) {
			

		

			int cnt = boardService.totalCount(pm);
			
			int epage = (pm.getPage()-1)*15;
			
	

			// 설정해준 값들을 해당 객체에 담는다.
			
			pm.setEpage(epage);
			
			System.out.println(pm.getTotalCount()+"위에서 찍는 토탈");

			pm.setTotalCount(cnt);
			System.out.println(pm.getPage()+"page?");
			System.out.println(pm.getStartPage()+"?");
			System.out.println(pm.getEndPage()+"?end");
			System.out.println(pm.getTotalCount()+"토탈");
			
		}
		
		List<BoardVO> board = boardService.selectboard(pm);

		
		System.out.println(pm.getPageNum()+"num");
		System.out.println(pm.isNext()+"next");
		
		
		model.addAttribute("pm", pm);
		model.addAttribute("board", board);
		
		return "board/boardlist";
		
	}
	
	@ResponseBody
	@RequestMapping("/report.do")
	public String report(ReportVO vo, MultipartHttpServletRequest multi, HttpSession session) throws IOException {
		
		// 저장 경로 설정
				String root = multi.getSession().getServletContext().getRealPath("/");
				String path = root+"resources/upload/";
				
				String newFileName = ""; // 업로드 되는 파일명
				
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
				
				File dir = new File(path);
				if(!dir.isDirectory()){
					dir.mkdir();
				}
				
				Iterator<String> files = multi.getFileNames();
				while(files.hasNext()){
					String uploadFile = files.next();
								
					MultipartFile mFile = multi.getFile(uploadFile);
					String fileName = mFile.getOriginalFilename();
					System.out.println("실제 파일 이름 : " +fileName);
					newFileName = formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+fileName;
					
					try {
						mFile.transferTo(new File(path+newFileName));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				vo.setAttach(newFileName);
				

		boardService.reportinsert(vo);
		
		return "";
	}
	
	
	
	
}
