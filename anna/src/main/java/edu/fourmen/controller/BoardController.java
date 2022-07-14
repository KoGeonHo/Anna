package edu.fourmen.controller;




import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;


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
	public String BoardWrite(BoardVO vo,HttpServletResponse response) throws IOException {
		
		
		// 파일 업로드 처리
		String fileName=null;
		String fileName2=null;
		MultipartFile uploadFile = vo.getFileName1();
		MultipartFile uploadFile2 = vo.getFileName2();
		

		
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile.transferTo(new File("C:\\Users\\753\\git\\Anna\\anna\\src\\main\\webapp\\resources\\upload" + fileName));
		}
		vo.setImage1(fileName);
		
		if (!uploadFile2.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName2=uuid+"."+ext;
			uploadFile.transferTo(new File("C:\\Users\\753\\git\\Anna\\anna\\src\\main\\webapp\\resources\\upload" + fileName));
		}
		vo.setImage2(fileName2);
		
		
		
		
		boardService.writeBoard(vo);
		return "board/FreeBoard"; 
	
		
		
		
	}
	
	


	


	
	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int Bidx,Model model) {
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		model.addAttribute("bv", bv);

		
		return "board/viewBoard";
	}
}
