package edu.fourmen.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;

@Repository
public class BoardItemDAO {
	
	/* 맵퍼에서 파라미터를 Map으로 쓰는법 해당 함수 안에 밑에꺼 작성
	 * Map<String,Object> newMap = new HashMap<String,Object>();
	 * 
	 * newMap.put("udix",vo.getUidx());
	 *  newMap.put("pageNum",pm.getPerPageNum());
	 */ 
	@Autowired(required=true)
	SqlSession sqlSession;
	
	private static final String efdb = "edu.fourmen.mapper.boardItemMapper";
	
	public List<BoardItemVO> selectAll(BoardItemVO vo,PageMaker pm) {
		return sqlSession.selectList(efdb+".selectAll",pm);
		
	}
	public List<BoardItemVO> selectAllbyuser(BoardItemVO vo,SearchVO svo) {
		return sqlSession.selectList(efdb+".selectAllbyuser",vo);
		
	}
		
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request) {
		return sqlSession.insert(efdb+".boarditemswrite",vo);
	}
	
	public BoardItemVO selectitem(int item_idx) {
		return sqlSession.selectOne(efdb+".selectitem",item_idx);
	}
	

	public int totalCount(PageMaker pm) {
		int result = sqlSession.selectOne(efdb+".totalCount",pm);
		return result;
	}
	
	public int itemmodify(BoardItemVO vo) {
		int result = sqlSession.update(efdb+".itemmodify",vo);
		return result;
	}
	public int itemdelete(BoardItemVO vo) {
	
		return sqlSession.update(efdb+".itemdelete",vo);
	}

	public BoardItemVO MinPrice(PageMaker pm) {

		return sqlSession.selectOne(efdb+".MinPrice",pm);
	}

	public int insertChat(ChatMessageVO cvo) {
		return sqlSession.insert(efdb+".insertChat",cvo);
	}
	
	public List<ChatMessageVO> selectChat(ChatMessageVO cvo) {
		return sqlSession.selectList(efdb+".selectChat",cvo);
	}
	
	public List<ChatMessageVO> mychatlist(ChatMessageVO cvo){
		return sqlSession.selectList(efdb+".mychatlist",cvo);
	}
	public int addNeighbor(BoardItemVO vo) {
		return sqlSession.insert(efdb+".addNeighbor",vo);
	}
	

	public int neighbor_check(BoardItemVO bvo) {
		return sqlSession.selectOne(efdb+".neighbor_check",bvo);
	}
	
	public int delneighbor(BoardItemVO vo) {
		return sqlSession.delete(efdb+".delneighbor",vo);
	}

}
