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
	
	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/upload/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/anna/resources/upload/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	


	
	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int Bidx,Model model) {
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		model.addAttribute("bv", bv);
		
		return "board/viewBoard";
	}
}
