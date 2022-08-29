package edu.fourmen.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.BoardItemService;
import edu.fourmen.service.CustomerService;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.QnAVO;

@RequestMapping(value="/customer")
@Controller
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	BoardItemService boardItemService;
	
	private String path = "/anna";

	
	//문의하기(QnA)게시판 목록
	@RequestMapping(value="/QnAList.do")
	public String QnAList(Model model,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<QnAVO> QnAList = customerService.getQnAList(uidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("QnAList",QnAList);
		
		return "customer/QnAList";
		
	}
	
	//문의하기(QnA)게시판 작성페이지
	@RequestMapping(value="/QnAWrite.do",method=RequestMethod.GET)
	public String QnAWrite(Model model) {
		
		model.addAttribute("path",path);
		
		return "customer/QnAWrite";
	}
	
	//문의하기(QnA)게시판 입력처리
	@RequestMapping(value="/QnAWrite.do",method=RequestMethod.POST)
	public String QnAWrite(QnAVO vo,HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		
		session = request.getSession();
		
		//System.out.println(vo.getTitle());
		//System.out.println(vo.getqType());
		//System.out.println(vo.getContents());
		
		String path = session.getServletContext().getRealPath("/resources/QnA/");
		File dir = new File(path); 
		
		//System.out.println(path);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		Date dateForFileName = new Date();
		SimpleDateFormat DateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		
		String fileName = DateFormat.format(dateForFileName) + "_" + String.valueOf(session.getAttribute("uidx")) + "_" + vo.getAttachFile().getOriginalFilename();
		//System.out.println(fileName);
		
		//System.out.println(vo.getAttachFile().getOriginalFilename().isEmpty());
		
		if(!vo.getAttachFile().getOriginalFilename().isEmpty()) {
			vo.getAttachFile().transferTo(new File(path,fileName));
		}
		
		vo.setUidx(Integer.parseInt(String.valueOf(session.getAttribute("uidx"))));
		vo.setAttach(fileName);
		
		//System.out.println(vo.getAttach());
		
		int result = customerService.QnAWrite(vo);
		
		return "redirect:/customer/QnAList.do";
	}
	
	//문의하기(QnA)게시판 조회페이지
	@RequestMapping(value="/QnAView.do")
	public String QnAView(int qidx,Model model) {
		
		QnAVO QnAItem = customerService.QnAView(qidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("QnAItem",QnAItem);
		
		return "customer/QnAView";
	}
	
	//문의하기(QnA)게시판 삭제 처리
	@RequestMapping(value="/QnADel.do")
	public String QnADel(int qidx) {
		
		int result = customerService.QnADel(qidx);
		
		return "redirect:/customer/QnAList.do";
	}
	
	//문의하기 관리자 답변
	@RequestMapping(value="/QnAAnswer.do")
	public String QnAAnswer(QnAVO vo,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int ans_uidx = (int)session.getAttribute("uidx");
		
		vo.setAns_uidx(ans_uidx);
		
		int result = customerService.QnAAnswer(vo);
		
		ChatMessageVO alarmVO = new ChatMessageVO();
		
		alarmVO.setUidx(ans_uidx);
		alarmVO.setItem_idx(0);
		alarmVO.setChat_host(ans_uidx);
		alarmVO.setInvited(vo.getUidx());
		alarmVO.setContents("<div>문의하신 글에 답변이 등록되었습니다. <span onclick='location.href=\""+path+"/customer/QnAView.do?qidx="+vo.getQidx()+"\"'>바로가기</span></div>");
		
		boardItemService.insertChat(alarmVO);
		
		return "redirect:/customer/QnAView.do?qidx="+vo.getQidx();
		
	}
	
	
	//자주묻는질문(FAQ)
		@RequestMapping(value="/FaQList.do")
		public String FaQList(Model model) {			
			
			
			model.addAttribute("path",path);
			
			return "customer/FaQList";
			
		}
	
	
}















