package edu.fourmen.controller;

import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.File;
import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String itemwrite(BoardItemVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session,Model model) throws IllegalStateException, IOException {
		

		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		int i = 1;
		String fileName = null;
		UUID uuid = UUID.randomUUID();
		System.out.println(vo.getFile1()+"파일1");
		
		
		if(vo.getFile1() != null) {
		MultipartFile uploadFile1 = vo.getFile1();
//		String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if(!uploadFile1.isEmpty()){
			fileName = uuid+"_"+uploadFile1.getOriginalFilename();
			uploadFile1.transferTo(new File(path,fileName));
			}
			vo.setImage1(fileName);
		}
		
		if(vo.getFile2() != null) {
		MultipartFile uploadFile2 = vo.getFile2();
			if(!uploadFile2.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile2.getOriginalFilename();
			uploadFile2.transferTo(new File(path,fileName));
			}
			vo.setImage2(fileName);
		}

		if(vo.getFile3() != null) {
		MultipartFile uploadFile3 = vo.getFile3();
			if(!uploadFile3.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile3.getOriginalFilename();
			uploadFile3.transferTo(new File(path,fileName));
			}
			vo.setImage3(fileName);
		}

		if(vo.getFile4() != null) {
		MultipartFile uploadFile4 = vo.getFile4();
			if(!uploadFile4.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile4.getOriginalFilename();
			uploadFile4.transferTo(new File(path,fileName));
			}
			vo.setImage4(fileName);
		}

		if(vo.getFile5() != null) {
		MultipartFile uploadFile5 = vo.getFile5();
			if(!uploadFile5.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile5.getOriginalFilename();
			uploadFile5.transferTo(new File(path,fileName));
			}
			vo.setImage5(fileName);
		}

		if(vo.getFile6() != null) {
		MultipartFile uploadFile6 = vo.getFile6();
			if(!uploadFile6.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile6.getOriginalFilename();
			uploadFile6.transferTo(new File(path,fileName));
			}
			vo.setImage6(fileName);
		}

		if(vo.getFile7() != null) {
		MultipartFile uploadFile7 = vo.getFile7();
			if(!uploadFile7.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile7.getOriginalFilename();
			uploadFile7.transferTo(new File(path,fileName));
			}
			vo.setImage7(fileName);
		}

		if(vo.getFile8() != null) {
		MultipartFile uploadFile8 = vo.getFile8();
			if(!uploadFile8.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile8.getOriginalFilename();
			uploadFile8.transferTo(new File(path,fileName));
			}
			vo.setImage8(fileName);
		}

		if(vo.getFile9() != null) {
		MultipartFile uploadFile9 = vo.getFile9();
			if(!uploadFile9.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile9.getOriginalFilename();
			uploadFile9.transferTo(new File(path,fileName));
			}
			vo.setImage9(fileName);
		}

		if(vo.getFile10() != null) {
		MultipartFile uploadFile10 = vo.getFile10();
			if(!uploadFile10.isEmpty()){
				//	String uploadFile22 = uploadFile2.getOriginalFilename()+uuid.toString();
			fileName = uuid+"_"+uploadFile10.getOriginalFilename();
			uploadFile10.transferTo(new File(path,fileName));
			}
			vo.setImage10(fileName);
		}
		//첫번째 추정. uploadfile1에 vo.getFile1() 을 담고 upload11에 upoadfile 의 정보를 넣어줌. 
		// 파일명과 uuid 를 넣으 String 타입으로 만들어 null 과 비교. 이름값이 있다면 null이 아니라 아래 if문을 돌릴것으로 추측
		// "" 사용하여 공백도 고려해볼것. 
		
		
		
		//두번째 
		/*
		 * String name = vo.getFile1().getOriginalFilename(); File file = new
		 * File(name); if() {
		 * 
		 * }
		 */
		
		//String file1 = "";
		/*
		 * if(vo.getFile1().getOriginalFilename() == "" ||
		 * !vo.getFile1().getOriginalFilename().isEmpty()) {
		 * vo.getFile1().transferTo(new File(path,
		 * vo.getFile1().getOriginalFilename()+(i++))); //화면에서 넘어온 파일을 path 위치에 새로쓰는 로직
		 * vo.setImage1(vo.getFile1().getOriginalFilename());
		 * System.out.println(vo.getFile1().getOriginalFilename()+"1111111"); }
		 * if(vo.getFile2().getOriginalFilename() == "" ||
		 * !vo.getFile2().getOriginalFilename().isEmpty()) {
		 * vo.getFile2().transferTo(new File(path,
		 * vo.getFile2().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile2().getOriginalFilename()+"22222222222");
		 * vo.setImage2(vo.getFile2().getOriginalFilename()); }
		 * 
		 * if(vo.getFile3().getOriginalFilename() == "" ||
		 * !vo.getFile3().getOriginalFilename().isEmpty()) {
		 * vo.getFile3().transferTo(new
		 * File(path,vo.getFile3().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile3().getOriginalFilename()+"3333333333333");
		 * vo.setImage3(vo.getFile3().getOriginalFilename()); }
		 * 
		 * if(vo.getFile4().getOriginalFilename() == "" ||
		 * !vo.getFile4().getOriginalFilename().isEmpty()) {
		 * vo.getFile4().transferTo(new
		 * File(path,vo.getFile4().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile4().getOriginalFilename()+"3333333333333");
		 * vo.setImage4(vo.getFile4().getOriginalFilename()); }
		 * 
		 * if(vo.getFile5().getOriginalFilename() == "" ||
		 * !vo.getFile5().getOriginalFilename().isEmpty()) {
		 * vo.getFile5().transferTo(new
		 * File(path,vo.getFile5().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile5().getOriginalFilename()+"3333333333333");
		 * vo.setImage5(vo.getFile5().getOriginalFilename()); }
		 * 
		 * if(vo.getFile6().getOriginalFilename() == "" ||
		 * !vo.getFile6().getOriginalFilename().isEmpty()) {
		 * vo.getFile6().transferTo(new
		 * File(path,vo.getFile6().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile6().getOriginalFilename()+"3333333333333");
		 * vo.setImage6(vo.getFile6().getOriginalFilename()); }
		 * 
		 * if(vo.getFile7().getOriginalFilename() == "" ||
		 * !vo.getFile7().getOriginalFilename().isEmpty()) {
		 * vo.getFile7().transferTo(new
		 * File(path,vo.getFile7().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile7().getOriginalFilename()+"3333333333333");
		 * vo.setImage7(vo.getFile7().getOriginalFilename()); }
		 * 
		 * if(vo.getFile8().getOriginalFilename() == "" ||
		 * !vo.getFile8().getOriginalFilename().isEmpty()) {
		 * vo.getFile8().transferTo(new
		 * File(path,vo.getFile8().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile8().getOriginalFilename()+"3333333333333");
		 * vo.setImage8(vo.getFile8().getOriginalFilename()); }
		 * 
		 * if(vo.getFile9().getOriginalFilename() == "" ||
		 * !vo.getFile9().getOriginalFilename().isEmpty()) {
		 * vo.getFile9().transferTo(new
		 * File(path,vo.getFile9().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile9().getOriginalFilename()+"3333333333333");
		 * vo.setImage9(vo.getFile9().getOriginalFilename()); }
		 * 
		 * if(vo.getFile10().getOriginalFilename() == "" ||
		 * !vo.getFile10().getOriginalFilename().isEmpty()) {
		 * vo.getFile10().transferTo(new
		 * File(path,vo.getFile10().getOriginalFilename()+(i++)));
		 * System.out.println(vo.getFile10().getOriginalFilename()+"3333333333333");
		 * vo.setImage10(vo.getFile10().getOriginalFilename()); }
		 */
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
		/*
		 * File dir = new File(path); // path가 존재하는지 여부 확인 if(!dir.exists()) {
		 * dir.mkdirs(); // 위치가 존재하지 않는 경우 위치 생성 }
		 */
			
		/*
		 * vo.getImage1().getOriginalFilename(); vo.getImage2().getOriginalFilename();
		 * // vo.getImage3().getOriginalFilename();
		 */		
				
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
