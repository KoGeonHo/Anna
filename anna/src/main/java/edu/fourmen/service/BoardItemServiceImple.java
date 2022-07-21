package edu.fourmen.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardItemDAO;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.PageMaker;

import edu.fourmen.vo.SearchVO;


@Service
public  class BoardItemServiceImple implements BoardItemService{


	@Autowired
	BoardItemDAO boarditemdao;
	
	
	@Override
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request) {
		return boarditemdao.boarditemswrite(vo,request);
	}


	@Override
	public BoardItemVO selectitem(int item_idx) {
		return boarditemdao.selectitem(item_idx);
	}


	@Override
	public List<BoardItemVO> list(BoardItemVO vo,PageMaker pm) {
		
		return boarditemdao.selectAll(vo,pm);
	}




	@Override
	public int totalCount(PageMaker pm) {
		return boarditemdao.totalCount(pm);
	}


	@Override
	public List<BoardItemVO> list2(BoardItemVO vo, SearchVO svo) {
		return boarditemdao.selectAllbyuser(vo, svo);
	}


	@Override
	public int itemmodify(BoardItemVO vo) {
		return boarditemdao.itemmodify(vo);
	}


	@Override
	public int itemdelete(BoardItemVO vo) {
		return boarditemdao.itemdelete(vo);
	}


	@Override
	public List<BoardItemVO> MinPrice(PageMaker pm) {
		return boarditemdao.MinPrice(pm);
	}					


}
