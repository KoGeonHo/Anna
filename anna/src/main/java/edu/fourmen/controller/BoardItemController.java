package edu.fourmen.controller;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.File;

import javax.imageio.ImageIO;
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
	public String itemwrite(BoardItemVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session,Model model,MultipartFile file) throws IllegalStateException, IOException {
		

		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		int i = 1;
		String fileName = null;
		UUID uuid = UUID.randomUUID();
		System.out.println(vo.getFile1().getOriginalFilename()+"파일1");
		
		
		if(vo.getFile1() != null) {
		MultipartFile uploadFile1 = vo.getFile1();
//		String uploadFile11 = uploadFile1.getOriginalFilename()+uuid.toString();
			if(!uploadFile1.isEmpty()){
			String fileName1 = uuid+"_"+uploadFile1.getOriginalFilename();
			uploadFile1.transferTo(new File(path,fileName1));
			System.out.println(uploadFile1.getOriginalFilename()+"두번째 if문 파일네임 입니다.");
			
			String imgpath = path+uploadFile1.getOriginalFilename();
			
			BufferedImage inputImage = ImageIO.read(file.getInputStream());
	        System.out.println(inputImage);
	        
			
			
			int newWidth = 500;   // 변경할 가로 길이
	        int newHeight = 300;  // 변경할 세로 길이
	        String option = newWidth+"x"+newHeight;
	        Image image = ImageIO.read(new File(path,uploadFile1.getOriginalFilename()));//원본 이미지 가져오기
	   // 이미지 품질 설정         
	        Image resizeImage = image.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
	        FileOutputStream out = new FileOutputStream(path +option+".jpg");
	        ImageIO.write((RenderedImage) resizeImage, "jpg", out);
	        //새 이미지 저장하기
	        BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
	            MultipartFile reimage = (MultipartFile) newImage;
	        
	            fileName = uuid+"_"+reimage.getOriginalFilename();
	            System.out.println(fileName+"리사이즈된 파일네임 입니다.");
				
				  Graphics graphics = newImage.getGraphics(); graphics.drawImage(resizeImage,
				  0, 0, null); graphics.dispose();
				 
			
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
