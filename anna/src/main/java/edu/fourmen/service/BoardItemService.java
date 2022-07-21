package edu.fourmen.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.PageMaker;
<<<<<<< HEAD


public interface BoardItemService {
	
	public List<BoardItemVO> list (BoardItemVO vo);
	
	public int totalcount();
=======
import edu.fourmen.vo.SearchVO;


public interface BoardItemService {
	
	public List<BoardItemVO> list (BoardItemVO vo, PageMaker pm);// 전체 리스트

	public List<BoardItemVO> list2 (BoardItemVO vo, SearchVO svo);//판매자의 다른상품
	
	public int totalCount(PageMaker pm);
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)
	
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request);
	
	public BoardItemVO selectitem(int item_idx);
}
