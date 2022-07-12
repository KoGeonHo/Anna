package edu.fourmen.controller;

import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import edu.fourmen.dao.BoardItemDAO;
import edu.fourmen.service.BoardItemService;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.UserVO;

@RequestMapping(value="/boarditem")
@Controller
public class BoardItemController {
	
	@Autowired
	BoardItemService boarditemService;
	
	@RequestMapping(value="itemlist.do")
	public String Trade(BoardItemVO vo, Model model) {
		
		List<BoardItemVO> list = boarditemService.list(vo);
		model.addAttribute("list", list);
		
		return "boarditem/itemlist";
	}

	
	@RequestMapping(value="itemview.do")
	public String selectitem(int item_idx,HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
		session = request.getSession();
		UserVO login = (UserVO)session.getAttribute("login");
		model.addAttribute("login",login);
		BoardItemVO vo = boarditemService.selectitem(item_idx);
		model.addAttribute("vo",vo);
		return "boarditem/itemview";
		
	}
	
	@RequestMapping(value="itemwrite.do", method=RequestMethod.GET)
	public String itemwrite() {
		
		return "boarditem/itemwrite"; 
	}
	
	@RequestMapping(value="itemwrite.do", method=RequestMethod.POST)
	public String itemwrite(BoardItemVO vo,Map<String, Object> map,MultipartFile file, HttpServletRequest request,HttpServletResponse response,  HttpSession session, MultipartHttpServletRequest mull,Model model) throws IllegalStateException, IOException {
		

		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		File dir = new File(path); // path가 존재하는지 여부 확인
		
		if(!dir.exists()) {
			dir.mkdirs(); // 위치가 존재하지 않는 경우 위치 생성
		}
		
			file.transferTo(new File(path, file.getOriginalFilename())); //화면에서 넘어온 파일을 path 위치에 새로쓰는 로직
			
			File image1 = new File(path, file.getOriginalFilename());
			System.out.println(image1+"오리지널@@@@@@@");
			vo.setImage1(path+file.getOriginalFilename());
		
		session = request.getSession();
		
		UserVO login = (UserVO)session.getAttribute("login");
		
		//vo.setMidx(login.getMidx());
		int result = boarditemService.boarditemswrite(vo,request);
		
		model.addAttribute("vo",vo);
		
		response.setContentType("text/html;charset=utf-8");
		
		
		
		
		/*
		 * PrintWriter pw = response.getWriter();
		 * 
		 * if(result <= 0) {
		 * pw.append("<script>alert('글쓰기 실패.');location.href='list.do';</script>");
		 * 
		 * pw.flush();
		 * 
		 * }else {
		 * pw.append("<script>alert('글쓰기 성공.');location.href='itemview.do?bidx="+vo.
		 * getBidx()+"';</script>"); pw.flush(); }
		 */
		
		return "redirect:/boarditem/itemview.do?item_idx="+vo.getItem_idx();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
