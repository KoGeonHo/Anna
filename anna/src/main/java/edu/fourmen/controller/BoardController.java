package edu.fourmen.controller;




import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.multipart.MultipartFile;



import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard(Model model, SearchVO svo) {
		
		List<BoardVO> freeboard = boardService.selectfreeboard(svo);
		System.out.println(svo);
		model.addAttribute("freeboard", freeboard);
		model.addAttribute("svo", svo);
		
		
		
		
		
		
		

		
		return "board/FreeBoard";
	}
	
	@RequestMapping(value="/BoardWrite.do", method= RequestMethod.GET)
	public String BoardWrite() {
		
		return "board/BoardWrite";
	}
	
	@RequestMapping(value="/BoardWrite.do", method = RequestMethod.POST)
	public String BoardWrite(BoardVO vo,HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		
		// 파일 업로드 처리


		String fileName=null;

		
		
		
		
	if(vo.getFileName1() != null) {
		MultipartFile uploadFile = vo.getFileName1();
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
			String oPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName; // 원본 경로
			File oFile = new File(oPath); //파일 클래스를 생성 그 안에 원본 경로를 담는다.

			int index = oPath.lastIndexOf("."); //문자열에서 특정 문자열의 위치 값(index)를 반환한다.
												//indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
												//lastIndexOf는 마지막 문자열의 index를 반환한다.
												// 확장자 찾으려고 "." 위치를 찾는듯하다
			
			String ext2 = oPath.substring(index + 1); // 파일 확장자  //해당 위치부터 해서 확장자 부분을 짜름(?)

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
			System.out.println(tPath+"썸넬 저장경로");
			File tFile = new File(tPath); //파일 클래스를 생성 그 안에 썸네일 저장경로를 담는다.

			double ratio = 2; // 이미지 축소 비율
			
			try {
				//(int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
				//(int) (oImage.getHeight() / ratio)// 생성할 썸네일이미지의 높이
				BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
				int tWidth =  200;// 생성할 썸네일이미지의 너비
				int tHeight = 200; // 생성할 썸네일이미지의 높이
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제

				ImageIO.write(tImage, ext2, tFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		vo.setImage1(fileName);
	}
	
	if(vo.getFileName2() != null) {
		MultipartFile uploadFile2 = vo.getFileName2();
		if (!uploadFile2.isEmpty()) {
			String originalFileName = uploadFile2.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile2.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
		}
		vo.setImage2(fileName);
	}
	
	if(vo.getFileName3() !=null) {
		MultipartFile uploadFile3 = vo.getFileName3();
		if (!uploadFile3.isEmpty()) {
			String originalFileName = uploadFile3.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile3.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
		}
		vo.setImage3(fileName);
	}
	
	if(vo.getFileName4() !=null) {
		MultipartFile uploadFile4 = vo.getFileName4();
		if (!uploadFile4.isEmpty()) {
			String originalFileName = uploadFile4.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile4.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
		}
		vo.setImage4(fileName);
	}
	
	if(vo.getFileName5() !=null) {
		MultipartFile uploadFile5 = vo.getFileName5();
		if (!uploadFile5.isEmpty()) {
			String originalFileName = uploadFile5.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile5.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
		}
		vo.setImage5(fileName);
	}
	
	

	
	

		
		boardService.writeBoard(vo);
		
	
		return "redirect:/board/FreeBoard.do"; 	
	}
	


	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int Bidx,Model model) {
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		model.addAttribute("bv", bv);

		
		return "board/viewBoard";
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}
