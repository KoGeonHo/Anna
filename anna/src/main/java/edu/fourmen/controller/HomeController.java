package edu.fourmen.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;

@Controller
public class HomeController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BoardItemService boardItemService;
	
	

	@RequestMapping(value = "/"  )
	public String main(Model model, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm, BoardItemVO vo) {
		
		
		//게시판 불러오기
		
				//한 페이지에 몇개씩 표시할 것인지
				int pagecount = 4;
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
				
				List<BoardVO> board = boardService.selectboard(pm);
			
				model.addAttribute("board", board);		
				model.addAttribute("pm", pm);
				
		
		// 게시판 불러오기
				
				
				
		//중고거래 불러오기
				
				//한 페이지에 몇개씩 표시할 것인지
				int pagecount1 = 15;
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
				
				
				
				
		return "index";
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
		totalRow = boardItemService.totalCount(pm);
		
		//전체 페이지 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		
		
		
		List<BoardItemVO> list = boardItemService.list(pm);
		
		HashMap<String, Object> result = new HashMap<String,Object>();

		result.put("appendList", list);
		
		return result;
	}
	
	
}
	
	

