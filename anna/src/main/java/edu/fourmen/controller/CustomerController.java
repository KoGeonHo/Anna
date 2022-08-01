package edu.fourmen.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.fourmen.service.CustomerService;
import edu.fourmen.vo.QnAVO;

@RequestMapping(value="/customer")
@Controller
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	private String path = "/anna";

	
	@RequestMapping(value="/QnA.do")
	public String QnA(Model model,HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		int uidx = (int)session.getAttribute("uidx");
		
		List<QnAVO> QnAList = customerService.getQnAList(uidx);
		
		model.addAttribute("path",path);
		
		model.addAttribute("QnAList",QnAList);
		
		return "customer/QnA";
		
	}
}
