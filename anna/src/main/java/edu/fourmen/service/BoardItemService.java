package edu.fourmen.service;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;



public interface BoardItemService {

	public List<BoardItemVO> list (BoardItemVO vo, PageMaker pm);// 전체 리스트

	public List<BoardItemVO> selectAllbyuser (BoardItemVO vo, SearchVO svo);//판매자의 다른상품
	
	public int totalCount(PageMaker pm);
	
	public int boarditemswrite(BoardItemVO vo);
	
	public BoardItemVO selectitem(int item_idx);
	
	public int itemmodify(BoardItemVO vo);
	
	public int update_state(int state, int item_idx);
	
	public int itemdelete(BoardItemVO vo);

	public List<BoardItemVO> MinPrice(PageMaker pm);

	public int insertChat(ChatMessageVO cvo);	
	
	public List<ChatMessageVO> selectChat(ChatMessageVO cvo);
	
	public List<ChatMessageVO> mychatlist(ChatMessageVO cvo);
	
	public List<ChatMessageVO> mychat(ChatMessageVO cvo);
	
	public int addNeighbor(BoardItemVO vo);
	
	public int neighbor_check(BoardItemVO bvo);
	
	public List<BoardItemVO> neighbor_list(BoardItemVO nvo);
	
	public int delneighbor(int neighbor_idx, int uidx);
	
	public int addWish(BoardItemVO vo);
	
	public int checkWish(BoardItemVO wvo);
	
	public int delWish(BoardItemVO wvo);
	
	public int report_target(ReportVO rvo);
	
	public int WishCount(BoardItemVO vo);
	
	public List<BoardItemVO> mywish(BoardItemVO vo);
	
	public int addviewCount(BoardItemVO vo);

	public int viewCount(BoardItemVO vo);
	
	public List<BoardItemVO> myblackList(BoardItemVO vo);
	  
	public int addblackList(BoardItemVO vo);
	
	public int delmyblackList(BoardItemVO vo);   
	
	
}
