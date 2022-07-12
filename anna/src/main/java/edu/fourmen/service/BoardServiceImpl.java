package edu.fourmen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardDAO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDao;
	
	
	@Override
	public int writeBoard(BoardVO vo) {
		
		return boardDao.writeBoard(vo);
	}


	@Override
	public List<BoardVO> selectfreeboard(SearchVO svo) {
		
		return boardDao.selectfreeboard(svo);
	}

}
