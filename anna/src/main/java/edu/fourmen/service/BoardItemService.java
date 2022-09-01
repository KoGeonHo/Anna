package edu.fourmen.service;


import java.util.List;


import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;



public interface BoardItemService {

	public List<BoardItemVO> list (PageMaker pm);// 전체 리스트

	public List<BoardItemVO> selectAllbyuser (int item_idx, int uidx);//판매자의 다른상품
	
	public int totalCount(PageMaker pm);
	
	public int boarditemswrite(BoardItemVO vo);
	
	public BoardItemVO selectitem(int item_idx);
	
	public int itemmodify(BoardItemVO vo);
	
	public int update_state(int state, int item_idx);
	
	public int itemdelete(int item_idx);

	public List<BoardItemVO> MinPrice(PageMaker pm);

	public int insertChat(ChatMessageVO cvo);	
	
	public List<ChatMessageVO> selectChat(ChatMessageVO cvo);
	
	public List<ChatMessageVO> mychatlist(ChatMessageVO cvo);
	
	public List<ChatMessageVO> mychat(ChatMessageVO cvo);
	
	public int addNeighbor(int neighbor_idx, int uidx);
	
	public int neighbor_check(int neighbor_idx, int uidx);
	
	public List<BoardItemVO> neighbor_list(BoardItemVO nvo);
	
	public int delneighbor(int neighbor_idx, int uidx);
	
	public int addWish(int item_idx , int uidx);
	
	public int checkWish(int item_idx, int uidx);
	
	public int delWish(int item_idx, int uidx);
	
	public int report_target(ReportVO rvo);
	
	public int WishCount(int item_idx);
	
	public List<BoardItemVO> mywish(BoardItemVO vo);
	
	public int addviewCount(int item_idx);

	public int viewCount(BoardItemVO vo);
	
	public List<BoardItemVO> myblackList(BoardItemVO vo);
	  
	public int addblackList(BoardItemVO vo);
	
	public int delmyblackList(BoardItemVO vo);   
	
	public int update_wdate(int item_idx);
	
}
