package edu.fourmen.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardItemDAO;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.Criteria;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO2;

@Service
public class BoardItemServiceImple implements BoardItemService{


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
	public int totalcount() {
		return  boarditemdao.totalcount();
	}


	@Override
	public List<BoardItemVO> list(SearchVO2 searchVO, BoardItemVO vo, Criteria criteria) {
		return boarditemdao.selectAll(vo,searchVO,criteria);
	}

}
