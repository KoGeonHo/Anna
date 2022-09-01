package edu.fourmen.dao;




import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
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
	
	public int totalCount(PageMaker pm) {
		
		HashMap<String,Object> HM = new HashMap<>();
		
		String[] locationList = null;
		
		if(pm.getLocation_auth() != null) {
			//System.out.println(pm.getLocation_auth()+"주소");
			locationList = pm.getLocation_auth().split(",");
		}
		
		HM.put("pm",pm);
		HM.put("locationList",locationList);
		
		int result = sqlSession.selectOne(namespace+".totalCount", HM);
		
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
		
		HashMap<String,Object> HM = new HashMap<>();
		
		String[] locationList = null;
		
		if(pm.getLocation_auth() != null) {
			locationList = pm.getLocation_auth().split(",");
		}
		
		//System.out.println("searchUidx:"+pm.getSearchUidx());
		
		HM.put("pm",pm);
		HM.put("locationList",locationList);
		
		
		return sqlSession.selectList(namespace+".selectboard",HM);
	}
	
	public int boardModify(BoardVO vo) {
		
		return sqlSession.update(namespace+".boardModify", vo);
	}
	
	public int reportinsert(ReportVO vo) {
		
		return sqlSession.insert(namespace+".reportinsert",vo);
	}
	
	public int replyDel(int reply_idx) {
		return sqlSession.delete(namespace+".replyDel", reply_idx);
	}
	
	public int replyModify(BoardVO vo) {
		return sqlSession.update(namespace+".replyModify",vo);
	}
}
