package edu.fourmen.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardDAO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
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
	public List<BoardVO> selectfreeboard(PageMaker pm) {
		
		return boardDao.selectfreeboard(pm);
	}

	


	@Override
	public BoardVO viewBoard(int Bidx) {
		
		return boardDao.viewBoard(Bidx);
	}


	@Override
	public int totalCount(PageMaker pm) {
		
		 return boardDao.totalCount(pm);
	}

	@Override
	public int commentwrite(BoardVO rv) {
		
		return boardDao.commentwrite(rv);
	}

	@Override
	public int getCTotal(BoardVO rv) {
		
		return boardDao.getCTotal(rv);
	}


	@Override
	public List<BoardVO> getCList(int Bidx) {
		
		return boardDao.getCList(Bidx);
	}


	@Override
	public int Ccount(int Bidx) {
		
		return boardDao.Ccount(Bidx);
	}


	@Override
	public int boardLikeUP(BoardVO vo) {
		
		return boardDao.boardLikeUP(vo);
	}


	@Override
	public int boardLikeDown(BoardVO vo) {
		
		return boardDao.boardLikeDown(vo);
	}


	@Override
	public int Likeyn(BoardVO vo) {
		
		return boardDao.Likeyn(vo);
	}


	@Override
	public List<BoardVO> selectjobboard(PageMaker pm) {
		
		return boardDao.selectjobboard(pm);
	}



}
