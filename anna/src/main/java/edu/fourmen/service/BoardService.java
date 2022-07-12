package edu.fourmen.service;

import java.util.List;

import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

public interface BoardService {

	
	int writeBoard(BoardVO vo);
	List<BoardVO> selectfreeboard(SearchVO svo);
}
