package edu.fourmen.controller;




import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import java.util.UUID;

import javax.imageio.ImageIO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import edu.fourmen.service.BoardService;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	
	@RequestMapping(value="/FreeBoard.do")
	public String FreeBoard(Model model, SearchVO svo, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
		session = request.getSession();
		
		//�븳 �럹�씠吏��뿉 紐뉕컻�뵫 �몴�떆�븷 寃껋씤吏�
		int pagecount = 12;
		//蹂댁뿬以� �럹�씠吏��쓽 踰덊샇瑜� �씪�떒 1�씠�씪怨� 珥덇린媛� 吏��젙
		int pagenumber = 1;
		//�럹�씠吏� 踰덊샇媛� �뙆�씪誘명꽣濡� �쟾�떖�릺�뒗吏� �씫�뼱��蹂몃떎.
		String strPageNum = request.getParameter("pagenumber");
		//留뚯씪 �럹�씠吏� 踰덊샇媛� �뙆由щ�명꽣濡� �꽆�뼱�삩�떎硫�
		if(strPageNum != null) {
			//�닽�옄濡� 諛붽퓭�꽌 蹂댁뿬以� �럹�씠吏� 踰덊샇瑜� 吏��젙�븳�떎.
			pagenumber = Integer.parseInt(strPageNum);
		}
		
		//蹂댁뿬以� �럹�씠吏��쓽 �떆�옉 ROWNUM - 0遺��꽣 �떆�옉
		int startPage = 0+ (pagenumber - 1)* pagecount;
		//蹂댁뿬以� �럹�씠吏��쓽 �걹 ROWNUM
		int endPage = pagenumber*pagecount;
		
		int pageNum = pagecount;
		
		// 寃��깋 �궎�썙�뱶 愿��젴�맂 泥섎━ - 寃��깋 �궎�썙�뱶媛� �꽆�뼱�삱 �닔 �룄 �엳怨� �븞 �꽆�뼱�삱 �닔�룄 �엳�떎.
		

		

		// �꽕�젙�빐以� 媛믩뱾�쓣 �빐�떦 媛앹껜�뿉 �떞�뒗�떎.
		pm.setStartPage(startPage);
		pm.setEndPage(endPage);
		pm.setPageNum(pageNum);
		
		//ArrayList 媛앹껜�쓽 李몄“媛믪쓣 �떞�쓣 吏��뿭蹂��닔瑜� 留뚮뱺�떎.
		ArrayList<PageMaker> plist = null;
		//�쟾泥� row�쓽 媛쒖닔瑜� �떞�쓣 吏��뿭蹂��닔瑜� 誘몃━ 留뚮뱺�떎. -寃��깋 議곌굔�씠 �뱾�뼱�삩 寃쎌슦 '寃��깋 寃곌낵 媛��닔'媛� �맂�떎.
		int totalRow = 0;

		//湲��쓽 媛쒖닔
		totalRow = boardService.totalCount(pm);
		
		//�쟾泥� �럹�씠吏� 媛��닔 援ы븯湲�
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		List<BoardVO> freeboard = boardService.selectfreeboard(pm);
		int Ccount = boardService.getCTotal(bv);
		
		bv.setCcount(Ccount);
	
		model.addAttribute("freeboard", freeboard);
		model.addAttribute("svo", svo);
		
		
		
		
		
		

		return "board/FreeBoard";
	}
	
	@RequestMapping(value="/BoardWrite.do", method= RequestMethod.GET)
	public String BoardWrite(HttpSession session, HttpServletRequest request, UserVO uv) {
		
		session = request.getSession();
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		System.out.println(formatter.format(date));

		return "board/BoardWrite";
	}
	
	@RequestMapping(value="/BoardWrite.do", method = RequestMethod.POST)
	public String BoardWrite(BoardVO vo,HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
		
		session = request.getSession();
		
		// �뙆�씪 �뾽濡쒕뱶 泥섎━

		String fileName=null;
		String fileName2=null;
		String fileName3=null;
		String fileName4=null;
		String fileName5=null;
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.format(date);
		
	if(vo.getFileName1() != null) {
		MultipartFile uploadFile = vo.getFileName1();
			//System.out.println(uploadFile);
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//�솗�옣�옄 援ы븯湲�
			//UUID uuid = UUID.randomUUID();	//UUID 援ы븯湲�
			fileName=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+originalFileName;
			//System.out.println(request.getSession().getServletContext().getRealPath("/main/resources/upload/"));
			uploadFile.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName));
			String oPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName; // �썝蹂� 寃쎈줈
			File oFile = new File(oPath); //�뙆�씪 �겢�옒�뒪瑜� �깮�꽦 洹� �븞�뿉 �썝蹂� 寃쎈줈瑜� �떞�뒗�떎.

			int index = oPath.lastIndexOf("."); //臾몄옄�뿴�뿉�꽌 �듅�젙 臾몄옄�뿴�쓽 �쐞移� 媛�(index)瑜� 諛섑솚�븳�떎.
												//indexOf媛� 泥섏쓬 諛쒓껄�릺�뒗 臾몄옄�뿴�뿉 ���븳 index瑜� 諛섑솚�븯�뒗 諛섎㈃,
												//lastIndexOf�뒗 留덉�留� 臾몄옄�뿴�쓽 index瑜� 諛섑솚�븳�떎.
												// �솗�옣�옄 李얠쑝�젮怨� "." �쐞移섎�� 李얜뒗�벏�븯�떎
			
			String ext2 = oPath.substring(index + 1); // �뙆�씪 �솗�옣�옄  //�빐�떦 �쐞移섎��꽣 �빐�꽌 �솗�옣�옄 遺�遺꾩쓣 吏쒕쫫(?)

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // �뜽�꽕�씪���옣 寃쎈줈
			System.out.println(tPath+"�뜽�꽟 ���옣寃쎈줈");
			File tFile = new File(tPath); //�뙆�씪 �겢�옒�뒪瑜� �깮�꽦 洹� �븞�뿉 �뜽�꽕�씪 ���옣寃쎈줈瑜� �떞�뒗�떎.

			//double ratio = 2; // �씠誘몄� 異뺤냼 鍮꾩쑉
			
			try {
				//(int) (oImage.getWidth() / ratio); // �깮�꽦�븷 �뜽�꽕�씪�씠誘몄��쓽 �꼫鍮�
				//(int) (oImage.getHeight() / ratio)// �깮�꽦�븷 �뜽�꽕�씪�씠誘몄��쓽 �넂�씠
				BufferedImage oImage = ImageIO.read(oFile); // �썝蹂몄씠誘몄�
				int tWidth =  200;// �깮�꽦�븷 �뜽�꽕�씪�씠誘몄��쓽 �꼫鍮�
				int tHeight = 200; // �깮�꽦�븷 �뜽�꽕�씪�씠誘몄��쓽 �넂�씠
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // �뜽�꽕�씪�씠誘몄�
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 由ъ냼�뒪瑜� 紐⑤몢 �빐�젣

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
			//String ext = FilenameUtils.getExtension(originalFileName);	//�솗�옣�옄 援ы븯湲�
			//UUID uuid = UUID.randomUUID();	//UUID 援ы븯湲�
			fileName2=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"2"+"_"+originalFileName;
			uploadFile2.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName2));
			System.out.println("�씠誘몄�2���옣�셿猷�");
		}
		vo.setImage2(fileName2);
	}
	
	if(vo.getFileName3() !=null) {
		MultipartFile uploadFile3 = vo.getFileName3();
		if (!uploadFile3.isEmpty()) {
			String originalFileName = uploadFile3.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//�솗�옣�옄 援ы븯湲�
			//UUID uuid = UUID.randomUUID();	//UUID 援ы븯湲�
			fileName3=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"3"+"_"+originalFileName;
			uploadFile3.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName3));
			System.out.println("�씠誘몄�3���옣�셿猷�");
		}
		vo.setImage3(fileName3);
	}
	
	if(vo.getFileName4() !=null) {
		MultipartFile uploadFile4 = vo.getFileName4();
		if (!uploadFile4.isEmpty()) {
			String originalFileName = uploadFile4.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//�솗�옣�옄 援ы븯湲�
			//UUID uuid = UUID.randomUUID();	//UUID 援ы븯湲�
			fileName4=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"4"+"_"+originalFileName;
			uploadFile4.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName4));
		}
		vo.setImage4(fileName4);
	}
	
	if(vo.getFileName5() !=null) {
		MultipartFile uploadFile5 = vo.getFileName5();
		if (!uploadFile5.isEmpty()) {
			String originalFileName = uploadFile5.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//�솗�옣�옄 援ы븯湲�
			//UUID uuid = UUID.randomUUID();	//UUID 援ы븯湲�
			fileName5=formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"5"+"_"+originalFileName;
			uploadFile5.transferTo(new File(request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName5));
		}
		vo.setImage5(fileName5);
	}
			boardService.writeBoard(vo);
		
	
		return "redirect:/board/FreeBoard.do"; 	
	}
	


	@RequestMapping(value="/viewBoard.do")
	public String viewBoard(int Bidx,Model model, HttpServletRequest request, HttpSession session) {
		
		model.addAttribute("path","/anna");
		
		session = request.getSession();
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		BoardVO vo = new BoardVO();
		
		boardService.HitUp(Bidx);
		
		vo.setBidx(Bidx);
		if(session.getAttribute("uidx") != null) {
			vo.setUidx(Integer.parseInt(String.valueOf(session.getAttribute("uidx"))));
		}
		model.addAttribute("bv", bv);
		model.addAttribute("like",boardService.Likeyn(vo));
		
		System.out.println("like");
		
		return "board/viewBoard";
	}
	
	

	@ResponseBody
	@RequestMapping(value="/InsertComment",produces = "application/text; charset=utf8")
	public String InsertComment(BoardVO rv, HttpServletRequest request, HttpSession session, int Bidx) {
		
		session = request.getSession();
		//rv.setUidx((int)session.getAttribute("uidx"));
		System.out.println("�뙎湲� �벑濡� �넻�떊 �꽦怨�");
//		if(session.getAttribute("login") == null) {
//			return "fail";
//		} else {
//			System.out.println("濡쒓렇�씤�븿. �뒪�겕�옪 吏꾪뻾");
			
		System.out.println(rv.getContents()); 
		System.out.println(rv.getNickName()); 
		System.out.println(rv.getBidx()); 
		
			boardService.commentwrite(rv);//�뙎湲��옉�꽦
			boardService.Ccount(Bidx);
			System.out.println("�뙎湲� �벑濡� �꽌鍮꾩뒪 �꽦怨�");
			return "InsertSuccess";
//		}
	}

	@ResponseBody
	@RequestMapping(value="/CommentList", produces = "application/json; charset=utf8")
	public Map<String, Object> getList(BoardVO rv, Model model) { // @PathVariable: URL 寃쎈줈�뿉 蹂��닔瑜� �꽔�뼱二쇰뒗
		System.out.println("�뙎湲� 紐⑸줉 而⑦듃濡ㅻ윭 �룞�옉");
		List<BoardVO> list = boardService.getCList(rv.getBidx());//�뙎湲�紐⑸줉
		int total = boardService.getCTotal(rv); //�뙎湲� 媛��닔
		ModelAndView view = new ModelAndView(); //�뜲�씠�꽣�� 酉곕�� �룞�떆�뿉 �꽕�젙�씠 媛��뒫
		System.out.println("�뙎湲� 媛��닔 " + boardService.getCTotal(rv)); //�뙎湲�媛��닔 �솗�씤�슜
		view.setViewName("/board/viewBoard"); //酉�
		Map<String, Object> map = new HashMap<>(); //�궎�� 諛몃쪟媛믪쑝濡� ���옣�븯�뒗
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}

	
	
	@ResponseBody 
	@RequestMapping(value="/likeUp", method=RequestMethod.POST)
	public void likeup(BoardVO vo, int Bidx, HttpSession session, HttpServletRequest request) {
		System.out.println("而⑦듃濡ㅻ윭 �뿰寃� �꽦怨�");
		
		session = request.getSession();
		
		vo.setBidx(Bidx);
		vo.setUidx((int)session.getAttribute("uidx"));
		
		System.out.println(Bidx);
		System.out.println((int)session.getAttribute("uidx"));

		boardService.boardLikeUP(vo);
	
	}
	
	@ResponseBody
	@RequestMapping(value="/likeDown", method=RequestMethod.POST)
	public void likeDown(BoardVO vo, int Bidx, HttpSession session, HttpServletRequest request) {
		
		session = request.getSession();
		
		System.out.println("醫뗭븘�슂 痍⑥냼!");
		
		vo.setBidx(Bidx);
		vo.setUidx((int)session.getAttribute("uidx"));
		
		System.out.println(Bidx);
		System.out.println((int)session.getAttribute("uidx"));
		boardService.boardLikeDown(vo);
	}


	
	@RequestMapping(value="/BoardDelete.do")
	public String BoardDelete(int Bidx,BoardVO vo) {
		
		vo.setBidx(Bidx);
		System.out.println("Bidx");
		
		boardService.boardDelete(Bidx);
		System.out.println("�궘�젣�셿猷�");
		
		return "redirect:/board/boardlist.do?board_type="+vo.getBoard_type();
	}
	
	@RequestMapping(value="/BoardModify.do", method=RequestMethod.GET)
	public String BoardModify(int Bidx, Model model) {
		
		BoardVO bv = boardService.viewBoard(Bidx);
		model.addAttribute("bv", bv);
		
		
		
		return "board/BoardModify";
	}
	
	@RequestMapping(value="/BoardModify.do", method=RequestMethod.POST)
	public String BoardModify(BoardVO vo, HttpServletRequest request, HttpSession session) throws IOException {
		
		
		session = request.getSession();
		boardService.boardModify(vo);
		System.out.println("�닔�젙�맖");
		System.out.println(vo.getBidx()+"bidx");
		
	
		return "redirect:/board/boardlist.do?board_type="+vo.getBoard_type(); //redirect://board/boardlist.do
	}
	
	@RequestMapping(value="/test.do")
	public String test(int Bidx,Model model, HttpServletRequest request, HttpSession session) {
				
		model.addAttribute("path","/anna");
		
		session = request.getSession();
		
		BoardVO bv = boardService.viewBoard(Bidx);
		
		BoardVO vo = new BoardVO();
		
		boardService.HitUp(Bidx);
		
		vo.setBidx(Bidx);
		if(session.getAttribute("uidx") != null) {
			vo.setUidx(Integer.parseInt(String.valueOf(session.getAttribute("uidx"))));
		}
		model.addAttribute("bv", bv);
		model.addAttribute("like",boardService.Likeyn(vo));
		
		System.out.println("like");
		
		return "board/test";
	}
	
	@RequestMapping(value="/boardlist.do") //寃뚯떆�뙋 �넻�빀
	public String boardlist(Model model, HttpServletRequest request, HttpSession session,BoardVO bv, PageMaker pm) {
		
		System.out.println(pm.getSearchUidx());
		
		String boardtype = "free";
		
		session = request.getSession();
		if(pm.getBoard_type().equals(boardtype)) {
		//�븳 �럹�씠吏��뿉 紐뉕컻�뵫 �몴�떆�븷 寃껋씤吏�
		int pagecount = 12;
		//蹂댁뿬以� �럹�씠吏��쓽 踰덊샇瑜� �씪�떒 1�씠�씪怨� 珥덇린媛� 吏��젙
		int pagenumber = 1;
		//�럹�씠吏� 踰덊샇媛� �뙆�씪誘명꽣濡� �쟾�떖�릺�뒗吏� �씫�뼱��蹂몃떎.
		String strPageNum = request.getParameter("pagenumber");
		//留뚯씪 �럹�씠吏� 踰덊샇媛� �뙆由щ�명꽣濡� �꽆�뼱�삩�떎硫�
		if(strPageNum != null) {
			//�닽�옄濡� 諛붽퓭�꽌 蹂댁뿬以� �럹�씠吏� 踰덊샇瑜� 吏��젙�븳�떎.
			pagenumber = Integer.parseInt(strPageNum);
		}
		
		//蹂댁뿬以� �럹�씠吏��쓽 �떆�옉 ROWNUM - 0遺��꽣 �떆�옉
		int startPage = 0+ (pagenumber - 1)* pagecount;
		//蹂댁뿬以� �럹�씠吏��쓽 �걹 ROWNUM
		int endPage = pagenumber*pagecount;
		
		int pageNum = pagecount;
		
		// 寃��깋 �궎�썙�뱶 愿��젴�맂 泥섎━ - 寃��깋 �궎�썙�뱶媛� �꽆�뼱�삱 �닔 �룄 �엳怨� �븞 �꽆�뼱�삱 �닔�룄 �엳�떎.
		

		

		// �꽕�젙�빐以� 媛믩뱾�쓣 �빐�떦 媛앹껜�뿉 �떞�뒗�떎.
		pm.setStartPage(startPage);
		pm.setEndPage(endPage);
		pm.setPageNum(pageNum);
		
		//ArrayList 媛앹껜�쓽 李몄“媛믪쓣 �떞�쓣 吏��뿭蹂��닔瑜� 留뚮뱺�떎.
		ArrayList<PageMaker> plist = null;
		//�쟾泥� row�쓽 媛쒖닔瑜� �떞�쓣 吏��뿭蹂��닔瑜� 誘몃━ 留뚮뱺�떎. -寃��깋 議곌굔�씠 �뱾�뼱�삩 寃쎌슦 '寃��깋 寃곌낵 媛��닔'媛� �맂�떎.
		int totalRow = 0;

		//湲��쓽 媛쒖닔
		totalRow = boardService.totalCount(pm);
		
		//�쟾泥� �럹�씠吏� 媛��닔 援ы븯湲�
		int totalPageCount = (int)Math.ceil(totalRow / (double)pagecount);
		
		request.setAttribute("plist", plist);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("pagenumber", pagenumber);
		
		
		
		}else if(!pm.getBoard_type().equals(boardtype)) {
			

		

			int cnt = boardService.totalCount(pm);
			
			int epage = (pm.getPage()-1)*15;
			
	

			// �꽕�젙�빐以� 媛믩뱾�쓣 �빐�떦 媛앹껜�뿉 �떞�뒗�떎.
			
			pm.setEpage(epage);
			
			System.out.println(pm.getTotalCount()+"�쐞�뿉�꽌 李띾뒗 �넗�깉");

			pm.setTotalCount(cnt);
			System.out.println(pm.getPage()+"page?");
			System.out.println(pm.getStartPage()+"?");
			System.out.println(pm.getEndPage()+"?end");
			System.out.println(pm.getTotalCount()+"�넗�깉");
			
		}
		
		List<BoardVO> board = boardService.selectboard(pm);

		
		System.out.println(pm.getPageNum()+"num");
		System.out.println(pm.isNext()+"next");
		
		
		model.addAttribute("pm", pm);
		model.addAttribute("board", board);
		
		return "board/boardlist";
		
	}
	
	@ResponseBody
	@RequestMapping("/report.do")
	public String report(ReportVO vo, MultipartHttpServletRequest multi, HttpSession session) throws IOException {
		
		// ���옣 寃쎈줈 �꽕�젙
				String root = multi.getSession().getServletContext().getRealPath("/");
				String path = root+"resources/upload/";
				
				String newFileName = ""; // �뾽濡쒕뱶 �릺�뒗 �뙆�씪紐�
				
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
				
				File dir = new File(path);
				if(!dir.isDirectory()){
					dir.mkdir();
				}
				
				Iterator<String> files = multi.getFileNames();
				while(files.hasNext()){
					String uploadFile = files.next();
								
					MultipartFile mFile = multi.getFile(uploadFile);
					String fileName = mFile.getOriginalFilename();
					System.out.println("�떎�젣 �뙆�씪 �씠由� : " +fileName);
					newFileName = formatter.format(date)+"_"+session.getAttribute("uidx")+"_"+"1"+"_"+fileName;
					
					try {
						mFile.transferTo(new File(path+newFileName));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				vo.setAttach(newFileName);
				

		boardService.reportinsert(vo);
		
		return "";
	}
	
	
	
	
}
