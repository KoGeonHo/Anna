package edu.fourmen.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;

@Controller
public class HomeController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "index";
	}

	@RequestMapping(value = "/main.do"  )
	public String main(Model model, HttpServletResponse response,HttpServletRequest request,HttpSession session, PageMaker pm) {
		
		ArrayList<PageMaker> plist = null;
		session = request.getSession(); 
		
		List<BoardVO> main = boardService.selectfreeboard(pm);
		
		model.addAttribute("plist", plist);
		
		
		return "main";
	}
	
}
	
	

