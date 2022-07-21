package edu.fourmen.service;

import java.util.List;



import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;

public interface BoardService {

	
	int writeBoard(BoardVO vo);
	
	List<BoardVO> selectfreeboard(PageMaker pm);

	BoardVO viewBoard(int Bidx);
	
	int totalCount(PageMaker pm);

	
	int commentwrite(BoardVO rv);
	
	int getCTotal(BoardVO rv);
	
	List<BoardVO> getCList(int Bidx);

}
