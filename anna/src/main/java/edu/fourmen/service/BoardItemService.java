package edu.fourmen.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.Criteria;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO2;


public interface BoardItemService {
	
	public List<BoardItemVO> list (SearchVO2 searchVO, BoardItemVO vo, Criteria criteria);
	
	public int totalcount();
	
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request);
	
	public BoardItemVO selectitem(int item_idx);
}
