package edu.fourmen.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.CustomerService;
import edu.fourmen.vo.QnAVO;

@RequestMapping(value="/customer")
@Controller
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	private String path = "/anna";

	
	@RequestMapping(value="/QnAList.do")
	public String QnAList(Model model,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<QnAVO> QnAList = customerService.getQnAList(uidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("QnAList",QnAList);
		
		return "customer/QnAList";
		
	}
	
	@RequestMapping(value="/QnAWrite.do",method=RequestMethod.GET)
	public String QnAWrite(Model model) {
		
		model.addAttribute("path",path);
		
		return "customer/QnAWrite";
	}
	
	@RequestMapping(value="/QnAWrite.do",method=RequestMethod.POST)
	public String QnAWrite(QnAVO vo,HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		session = request.getSession();
		
		System.out.println(vo.getTitle());
		System.out.println(vo.getqType());
		System.out.println(vo.getContents());
		
		String path = request.getSession().getServletContext().getRealPath("/resources/QnA/");
		File dir = new File(path); 
		
		System.out.println(path);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		//System.out.println(vo.getAttachFile().getOriginalFilename().isEmpty());
		
		if(!vo.getAttachFile().getOriginalFilename().isEmpty()) {
			vo.getAttachFile().transferTo(new File(path,vo.getAttachFile().getOriginalFilename()));
		}
		
		vo.setUidx((int)session.getAttribute("uidx"));
		vo.setAttach(vo.getAttachFile().getOriginalFilename());
		
		System.out.println(vo.getAttach());
		
		int result = customerService.QnAWrite(vo);
		
		return "redirect:/customer/QnAList.do";
	}
	
	@RequestMapping(value="/QnAView.do")
	public String QnAView(int qidx,Model model) {
		
		QnAVO QnAItem = customerService.QnAView(qidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("QnAItem",QnAItem);
		
		return "customer/QnAView";
	}
	
	@RequestMapping(value="/QnADel.do")
	public String QnADel(int qidx) {
		
		int result = customerService.QnADel(qidx);
		
		return "redirect:/customer/QnAList.do";
	}
}
