package edu.fourmen.controller;


import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) {
		
		return "index";
		
	}
	
	@RequestMapping(value="test")
	public String test() {
		
		return "test";
	}
	
	@RequestMapping(value="test2")
	public String test2() {
		
		return "test2";
	}
	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard() {
		
		return "/board/FreeBoard";
	}
	
}
