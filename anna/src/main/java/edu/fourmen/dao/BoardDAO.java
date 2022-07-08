package edu.fourmen.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardVO;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession sqlSession; //핵심적인 역할을 하는 클래스로서 SQL 실행이나 트랙잭션 관리를 실행한다.

	private static final String namespace = "edu.fourman.mapper.boardMapper"; //네임스페이스를 namespace로 줄임.	
	
	public int writeBoard(BoardVO vo) {
		
		int result = sqlSession.insert(namespace+".insert", vo);
		
		return result;
	}
}
