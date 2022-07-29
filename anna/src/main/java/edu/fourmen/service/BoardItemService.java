package edu.fourmen.service;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;

import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;



public interface BoardItemService {

	public List<BoardItemVO> list (BoardItemVO vo, PageMaker pm);// 전체 리스트

	public List<BoardItemVO> selectAllbyuser (BoardItemVO vo, SearchVO svo);//판매자의 다른상품
	
	public int totalCount(PageMaker pm);
	
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request);
	
	public BoardItemVO selectitem(int item_idx);
	
	public int itemmodify(BoardItemVO vo);
	
	public int itemdelete(BoardItemVO vo);

	public BoardItemVO MinPrice(PageMaker pm);

	public int insertChat(ChatMessageVO cvo);	
	
	public List selectChat(ChatMessageVO cvo);
	
	public int addNeighbor(BoardItemVO vo );
	
	public int neighbor_check(BoardItemVO vo);
	
	public int delneighbor(BoardItemVO vo);
}
