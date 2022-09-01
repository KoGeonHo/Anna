package edu.fourmen.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardDAO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
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
	public List<BoardVO> selectboard(PageMaker pm) {
		
		return boardDao.selectboard(pm);
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
	public int HitUp(int Bidx) {
		
		return boardDao.HitUp(Bidx);
	}


	@Override
	public int boardDelete(int Bidx) {
		
		return boardDao.boardDelete(Bidx);
	}


	@Override
	public int boardModify(BoardVO vo) {
		
		return boardDao.boardModify(vo);
	}


	@Override
	public int reportinsert(ReportVO vo) {
		
		return boardDao.reportinsert(vo);
	}


	@Override
	public int replyDel(int reply_idx) {
		
		return boardDao.replyDel(reply_idx);
	}


	@Override
	public int replyModify(BoardVO vo) {
		
		return boardDao.replyModify(vo);
	}



}
