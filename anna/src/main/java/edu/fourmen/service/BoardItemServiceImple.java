package edu.fourmen.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.BoardItemDAO;
import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;

import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;


@Service
public  class BoardItemServiceImple implements BoardItemService{


	@Autowired
	BoardItemDAO boarditemdao;
	
	
	@Override
	public int boarditemswrite(BoardItemVO vo) {
		return boarditemdao.boarditemswrite(vo);
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
	public List<BoardItemVO> selectAllbyuser(BoardItemVO vo, SearchVO svo) {
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
	public BoardItemVO MinPrice(PageMaker pm) {
		return boarditemdao.MinPrice(pm);

	}					

	@Override
	public int insertChat(ChatMessageVO cvo) {
		return boarditemdao.insertChat(cvo);
	}

	@Override
	public List<ChatMessageVO> selectChat(ChatMessageVO cvo) {
		return boarditemdao.selectChat(cvo);
	}

	@Override
	public List<ChatMessageVO> mychatlist(ChatMessageVO cvo) {
		return boarditemdao.mychatlist(cvo);
	}

	@Override
	public List<ChatMessageVO> mychat(ChatMessageVO cvo) {
		return boarditemdao.mychat(cvo);
	}
	@Override
	
	public int addNeighbor(BoardItemVO vo) {
		return boarditemdao.addNeighbor(vo);
	}


	@Override
	public int neighbor_check(BoardItemVO bvo) {
		int result = boarditemdao.neighbor_check(bvo);
		return result;
	}


	@Override
	public int delneighbor(BoardItemVO vo) {
		return boarditemdao.delneighbor(vo);
	}


	@Override
	public int addWish(BoardItemVO vo) {
		return boarditemdao.addwist(vo);
	}

	@Override
	public int checkWish(BoardItemVO wvo) {
		return boarditemdao.checkWish(wvo);
	}
	
	@Override
	public int delWish(BoardItemVO wvo) {
		return boarditemdao.delWish(wvo);
	}
	
	@Override
	public int report_target(BoardItemVO vo) {
		return boarditemdao.report_target(vo);
	}


	@Override
	public int WishCount(BoardItemVO vo) {
		return boarditemdao.WishCount(vo);
	}

	@Override
	public List<BoardItemVO> mywish(BoardItemVO vo) {
		return boarditemdao.mywish(vo);
	}
	
	
	
	
	@Override
	public int viewCount(BoardItemVO vo) {
		return boarditemdao.viewCount(vo);
	}


	@Override
	public int addviewCount(BoardItemVO vo) {
		return boarditemdao.addviewCount(vo);
	}


	@Override
	public List<BoardItemVO> myblackList(BoardItemVO vo) {
		return boarditemdao.myblackList(vo);
	}


	@Override
	public int addblackList(BoardItemVO vo) {
		return boarditemdao.addblackList(vo);
	}


	@Override
	public int delmyblackList(BoardItemVO vo) {
		return boarditemdao.delmyblackList(vo);
	}


	@Override
	public List<BoardItemVO> neighbor_list(BoardItemVO nvo) {
		return boarditemdao.neighbor_list(nvo);
	}


	
}
