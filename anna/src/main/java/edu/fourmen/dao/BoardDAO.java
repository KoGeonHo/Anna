package edu.fourmen.dao;




import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession sqlSession; //핵심적인 역할을 하는 클래스로서 SQL 실행이나 트랙잭션 관리를 실행한다.

	private static final String namespace = "edu.fourman.mapper.boardMapper"; //네임스페이스를 namespace로 줄임.	
	
	public int writeBoard(BoardVO vo) { //글작성하기
		
		int result = sqlSession.insert(namespace+".boardinsert", vo);
		
		return result;
	}
	
	public BoardVO viewBoard(int Bidx) { //글 내용 보기
		return sqlSession.selectOne(namespace+".viewBoard",Bidx);
	}
	
	public List<BoardVO> selectfreeboard(PageMaker pm){ //일상&소통 게시판리스트

		return sqlSession.selectList(namespace+".selectfreeboard", pm);
	}
	
	public List<BoardVO> selectjobboard(PageMaker pm){
		
		
		return sqlSession.selectList(namespace+".selectjobboard",pm);
	}
	
	public int totalCount(PageMaker pm) {
		
		int result = sqlSession.selectOne(namespace+".totalCount", pm);
		
		return result; 
	}
	

	public int commentwrite(BoardVO rv) { //댓글작성하기
		
		int result =sqlSession.insert(namespace+".commentwrite", rv);
		
		return result;
	}
	
	public int getCTotal(BoardVO rv) { //댓글 카운트
		
		return sqlSession.selectOne(namespace+".getCTotal", rv);
	}
	
	public List<BoardVO> getCList(int Bidx) { //댓글목록 불러오기
	
		return sqlSession.selectList(namespace+".getCList", Bidx);
	}
	
	public int Ccount(int Bidx) {
		
		return sqlSession.update(namespace+".Ccount", Bidx);
	}
	
	public int boardLikeUP(BoardVO vo) {
		
		return sqlSession.insert(namespace+".boardLikeUP", vo);
	}
	
	public int boardLikeDown(BoardVO vo) {
		
		return sqlSession.delete(namespace+".boardLikeDown",vo);
	}
	
	public int Likeyn(BoardVO vo) {
		return sqlSession.selectOne(namespace+".Likeyn",vo);
	}
	
	public int HitUp(int Bidx) {
		
		return sqlSession.update(namespace+".HitUp", Bidx);
	}
	
	public int boardDelete(int Bidx) {
		
		return sqlSession.update(namespace+".boardDelete", Bidx);
	}
	
	public List<BoardVO> selectboard(PageMaker pm){
		
		return sqlSession.selectList(namespace+".selectboard",pm);
	}
	
	public int boardModify(BoardVO vo) {
		
		return sqlSession.update(namespace+".boardModify", vo);
	}
	
	public int reportinsert(BoardVO vo) {
		
		return sqlSession.insert(namespace+".reportinsert",vo);
	}
}
