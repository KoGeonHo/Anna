package edu.fourmen.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard() {
		
		
		return "board/FreeBoard";
	}
	
	@RequestMapping(value="BoardWrite.do", method= RequestMethod.GET)
	public String BoardWrite() {
		
		return "board/BoardWrite";
	}
	
	@RequestMapping(value="BoardWrite.do", method = RequestMethod.POST)
	public void BoardWrite(BoardVO vo) {
		
		int result=boardService.writeBoard(vo);
		
		if(result == 1) {
			
			
			
		}else {
			
			
		}
		
	}
}
