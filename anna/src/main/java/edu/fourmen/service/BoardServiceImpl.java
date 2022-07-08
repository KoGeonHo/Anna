package edu.fourmen.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardDAO;
import edu.fourmen.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDao;
	
	
	@Override
	public int writeBoard(BoardVO vo) {
		
		return boardDao.writeBoard(vo);
	}

}
