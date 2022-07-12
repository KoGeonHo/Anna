package edu.fourmen.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import edu.fourmen.vo.BoardItemVO;


public interface BoardItemService {
	
	public List<BoardItemVO> list ( BoardItemVO vo);
	
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request);
	
	public BoardItemVO selectitem(int item_idx);
}
