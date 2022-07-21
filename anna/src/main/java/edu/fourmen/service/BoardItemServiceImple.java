package edu.fourmen.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardItemDAO;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.PageMaker;
<<<<<<< HEAD
=======
import edu.fourmen.vo.SearchVO;
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)

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
	public List<BoardItemVO> list(BoardItemVO vo) {
		
<<<<<<< HEAD
		return boarditemdao.selectAll(vo);
=======
		return boarditemdao.selectAll(vo,pm);
	}



	@Override
	public int totalCount(PageMaker pm) {
		return boarditemdao.totalCount(pm);
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)
	}


	@Override
	public int totalcount() {
		return  boarditemdao.totalcount();
	}

<<<<<<< HEAD
=======

	@Override
	public int itemmodify(BoardItemVO vo) {
		return boarditemdao.itemmodify(vo);
	}


	@Override
	public int itemdelete(BoardItemVO vo) {
		return boarditemdao.itemdelete(vo);
	}					

>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)
}
