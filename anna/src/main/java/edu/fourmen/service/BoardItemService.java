package edu.fourmen.service;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.PageMaker;

import edu.fourmen.vo.SearchVO;



public interface BoardItemService {

	public List<BoardItemVO> list (BoardItemVO vo, PageMaker pm);// 전체 리스트

	public List<BoardItemVO> list2 (BoardItemVO vo, SearchVO svo);//판매자의 다른상품
	
	public int totalCount(PageMaker pm);
	
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request);
	
	public BoardItemVO selectitem(int item_idx);
	
	public int itemmodify(BoardItemVO vo);
	
	public int itemdelete(BoardItemVO vo);
	
	public List<BoardItemVO> MinPrice(PageMaker pm,BoardItemVO vo);
}
