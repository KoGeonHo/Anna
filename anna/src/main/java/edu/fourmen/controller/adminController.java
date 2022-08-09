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
	

	
	

}
