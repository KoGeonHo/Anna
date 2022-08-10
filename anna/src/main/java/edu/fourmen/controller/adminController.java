package edu.fourmen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/admin")
public class adminController {
	
	@RequestMapping(value="/admin_user.do", method=RequestMethod.GET)
	public String admin_user() {
		
		return "admin/admin_user";
	}
	
	@RequestMapping(value="/admin_report")
	public String admin_report() {
		
		return "admin/admin_report";
	}
	
	@RequestMapping(value="/admin_boarditem")
	public String admin_boarditem() {
		
		return "admin/admin_boarditem";
	}
	
	@RequestMapping(value="/admin_qna")
	public String admin_qna() {
		
		return "admin/admin_qna";
	}
	
	@RequestMapping(value="/admin_notice")
	public String admin_notice() {
		
		return "admin/admin_notice";
	}
	
	@RequestMapping(value="/admin_board")
	public String admin_board() {
		
		return "admin/admin_board";
	}
	
	@RequestMapping(value="/admin_slide")
	public String admin_slide() {
		
		return "admin/admin_slide";
	}
	


	
	

}
