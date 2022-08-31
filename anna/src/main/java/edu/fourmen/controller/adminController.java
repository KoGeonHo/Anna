package edu.fourmen.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.fourmen.service.AdminService;
import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.BoardService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.QnAVO;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.SlideVO;
import edu.fourmen.vo.UserVO;

@Controller
@RequestMapping(value="/admin")
public class adminController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BoardItemService boardItemService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value="/admin_user.do", method=RequestMethod.GET)
	public String admin_user(Model model) {
		
		List<UserVO> uList = adminService.getUserList();
		
		model.addAttribute("UserList", uList );
		
		return "admin/admin_user";
	}
	
	@RequestMapping(value="/admin_report.do", method=RequestMethod.GET)
	public String admin_report(Model model) { 
		
		List<ReportVO> ReportList = adminService.getReportList();
		
		model.addAttribute("ReportList",ReportList);
		
		return "admin/admin_report";
	}
	
	@ResponseBody
	@RequestMapping(value="/reportview", produces = "application/json; charset=utf8")
	public Map<String, Object> getList(ReportVO rv, Model model) { // @PathVariable: URL 경로에 변수를 넣어주는
		System.out.println("댓글 목록 컨트롤러 동작");
		List<ReportVO> list = adminService.getReportView(rv.getRidx());//댓글목록
		
		ModelAndView view = new ModelAndView(); //데이터와 뷰를 동시에 설정이 가능
		view.setViewName("/admin/admin.report"); //뷰
		Map<String, Object> map = new HashMap<>(); //키와 밸류값으로 저장하는
		map.put("list", list);
		
		
		
		return map;
	}
	
	@RequestMapping(value="/admin_report.do", method=RequestMethod.POST)
	public void reportapply(ReportVO rv,HttpServletResponse response) throws IOException { //신고적용
		
		int result = adminService.reportapply(rv.getRidx());
		
		PrintWriter pw = response.getWriter();
		
		System.out.println(rv.getRidx() + "ridx");


		if(result==0) {
			
			pw.append("<script>alert('신고적용실패');location.href='admin_report.do';</script>");
			pw.flush();
		}else {
			pw.append("<script>alert('신고적용');location.href='admin_report.do';</script>");
			pw.flush();
			
		}
		
		System.out.println("너 밴");
	}

	
	@RequestMapping(value="/admin_boarditem")
	public String admin_boarditem(Model model, HttpServletRequest request, HttpSession session, PageMaker pm, BoardItemVO vo) {
		
		//중고거래 불러오기
		
		//한 페이지에 몇개씩 표시할 것인지
		int pagecount1 = 1000;
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pagenumber1 = 1;
		//페이지 번호가 파라미터로 전달되는지 읽어와본다.
		String strPageNum1 = request.getParameter("pagenumber");
		//만일 페이지 번호가 파리미터로 넘어온다면
		if(strPageNum1 != null) {
			//숫자로 바꿔서 보여줄 페이지 번호를 지정한다.
			pagenumber1 = Integer.parseInt(strPageNum1);
		}
		
		//보여줄 페이지의 시작 ROWNUM - 0부터 시작
		int startPage = 0+ (pagenumber1 - 1)* pagecount1;
		//보여줄 페이지의 끝 ROWNUM
		int endPage = pagenumber1*pagecount1;
		
		int pageNum_1 = pagecount1;
		
		// 검색 키워드 관련된 처리 - 검색 키워드가 넘어올 수 도 있고 안 넘어올 수도 있다.

		// 설정해준 값들을 해당 객체에 담는다.
		pm.setStartPage(startPage);
		pm.setEndPage(endPage);
		pm.setPageNum(pageNum_1);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 만든다.
		ArrayList<PageMaker> plist_1 = null;
		//전체 row의 개수를 담을 지역변수를 미리 만든다. -검색 조건이 들어온 경우 '검색 결과 갯수'가 된다.
		int totalRow_1 = 0;

		//글의 개수
		totalRow_1 = boardItemService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow_1 / (double)pagecount1);
		
		request.setAttribute("plist_1", plist_1);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow_1);
		request.setAttribute("pagenumber", pagenumber1);		

		
		//전체 상품 리스트 받아오기
	    List<BoardItemVO> list = boardItemService.list(pm);
	    
	    
	    boardItemService.MinPrice(pm);
	    

	    model.addAttribute("pm",pm);
	    model.addAttribute("list", list);


		
//중고거래 불러오기
		
		
		return "admin/admin_boarditem";
	}
	
	@RequestMapping(value="/admin_qna")
	public String admin_qna(Model model) {
		
		List<QnAVO> qnaList = adminService.getQnaList();
		
		model.addAttribute("QnAList", qnaList);		
		
		return "admin/admin_qna";
	}
	
	@RequestMapping(value="/admin_notice")
	public String admin_notice(Model model) {		
		
		PageMaker pm = new PageMaker();
		
		pm.setBoard_type("notice");
		
		List<BoardVO> noticeList = boardService.selectboard(pm);
		
		model.addAttribute("noticeList",noticeList);
		
		return "admin/admin_notice";
	}
	
	@RequestMapping(value="/admin_board")
	public String admin_board(Model model, SearchVO svo, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
		
		//게시판 불러오기
		
		//한 페이지에 몇개씩 표시할 것인지
		int pagecount = 300;
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pagenumber = 1;
		//페이지 번호가 파라미터로 전달되는지 읽어와본다.
		String strPageNum = request.getParameter("pagenumber");
		//만일 페이지 번호가 파리미터로 넘어온다면
		if(strPageNum != null) {
			//숫자로 바꿔서 보여줄 페이지 번호를 지정한다.
			pagenumber = Integer.parseInt(strPageNum);
		}				
		
		int pageNum = pagecount;
		

		// 설정해준 값들을 해당 객체에 담는다.
		pm.setPageNum(pageNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 만든다.
		ArrayList<PageMaker> plist = null;
		//전체 row의 개수를 담을 지역변수를 미리 만든다. -검색 조건이 들어온 경우 '검색 결과 갯수'가 된다.
		int totalRow = 0;

		//글의 개수
		totalRow = boardService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		
		request.setAttribute("plist", plist);
		
		List<BoardVO> freeboard = boardService.selectboard(pm);
	
		model.addAttribute("freeboard", freeboard);	
		model.addAttribute("svo", svo);

// 게시판 불러오기
		
		
		return "admin/admin_board";
	}
	
	@RequestMapping(value="/admin_slide" , method= RequestMethod.GET)
	public String admin_slide( HttpSession session, HttpServletRequest request) {
		
		return "admin/admin_slide";
	}
	
	
	@RequestMapping(value="/admin_slide" , method= RequestMethod.POST)
	public String admin_slide(MultipartFile upload, HttpServletResponse response, HttpSession session, HttpServletRequest request) {
		
		  //파일이 업로드 될 경로 설정
        String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload");

        //위에서 설정한 경로의 폴더가 없을 경우 생성
        File dir = new File(saveDir);
        if(!dir.exists()) {
            dir.mkdirs();
        }

        // 파일 업로드
		/*
		 * for(MultipartFile f : upload) { if(!f.isEmpty()) { // 기존 파일 이름을 받고 확장자 저장
		 * String orifileName = f.getOriginalFilename(); String ext =
		 * orifileName.substring(orifileName.lastIndexOf("."));
		 * 
		 * // 이름 값 변경을 위한 설정 SimpleDateFormat sdf = new
		 * SimpleDateFormat("yyyyMMdd-HHmmssSSS"); int rand = (int)(Math.random()*1000);
		 * 
		 * // 파일 이름 변경 String reName = sdf.format(System.currentTimeMillis()) + "_" +
		 * rand + ext;
		 * 
		 * // 파일 저장 try { f.transferTo(new File(saveDir + "/" + reName)); }catch
		 * (IllegalStateException | IOException e) { e.printStackTrace(); } } }
		 */
	
		
		return "redirect:admin/admin_slide";
	}
	
	@RequestMapping(value="/admin_slideWrite.do")
	public String admin_slideWrite( ) {
		
		return "admin/admin_slideWrite";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/toggleAdmin.do")
	public void toggleAdmin(int uidx,String isAdmin) {
		
		UserVO vo = new UserVO();
		
		vo.setUidx(uidx);
		vo.setIsAdmin(isAdmin);
		
		adminService.toggleAdmin(vo);
		
		
	}
	
	

}
