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
	
	public List<BoardVO> selectfreeboard(PageMaker pm){ //일상&소통 게시판리스트 // 갤러리형
		return sqlSession.selectList(namespace+".selectfreeboard", pm);
	}
	
	public int totalCount(PageMaker pm) { //글 갯수 카운트
		
		int result = sqlSession.selectOne(namespace+".totalCount", pm);
		
		return result; 
	}
	
	public int commentwrite(BoardVO bv) { //댓글작성하기
		
		int result =sqlSession.insert(namespace+".commentwrite", bv);
		
		return result;
	}
	
	public int getCTotal(BoardVO bv) { //댓글 카운트
		
		return sqlSession.selectOne(namespace+".getCTotal", bv);
	}
	
	public List<BoardVO> getCList(int Bidx) { //댓글목록 불러오기
	
		return sqlSession.selectList(namespace+".getCList", Bidx);
	}
	
}
