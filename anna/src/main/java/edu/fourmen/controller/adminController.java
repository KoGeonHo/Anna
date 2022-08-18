package edu.fourmen.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.AdminService;
import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.BoardService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.QnAVO;
import edu.fourmen.vo.SearchVO;
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
	
	@RequestMapping(value="/admin_report")
	public String admin_report() {
		
		return "admin/admin_report";
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
	public String admin_notice() {		
		
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
	
	@RequestMapping(value="/admin_slide")
	public String admin_slide() {
		
		return "admin/admin_slide";
	}
	


	
	

}
