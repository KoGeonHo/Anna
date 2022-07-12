package edu.fourmen.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard(Model model, SearchVO svo) {
		
		List<BoardVO> freeboard = boardService.selectfreeboard(svo);
		System.out.println(svo);
		model.addAttribute("freeboard", freeboard);
		model.addAttribute("svo", svo);
		
		
		return "board/FreeBoard";
	}
	
	@RequestMapping(value="/BoardWrite.do", method= RequestMethod.GET)
	public String BoardWrite() {
		
		return "board/BoardWrite";
	}
	
	@RequestMapping(value="/BoardWrite.do", method = RequestMethod.POST)
	public void BoardWrite(BoardVO vo,HttpServletResponse response) throws IOException {
		
		
		response.setContentType("text/html;charset=utf-8");
		  PrintWriter pw = response.getWriter();
		
		int result=boardService.writeBoard(vo);
		
		if(result == 1) {
			pw.append("<script>alert('등록완료.');location.href='FreeBoard.do'</script>");
			pw.flush();
			
		}else {
			pw.append("<script>alert('등록이 되지 않았습니다.');location.href='FreeBoard.do'</script>");
			pw.flush();
			
		}
		
	}
	
	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int bidx,Model model) {
		
		return "board/viewBoard";
	}
}
