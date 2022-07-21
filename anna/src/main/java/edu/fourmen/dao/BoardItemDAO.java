package edu.fourmen.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
<<<<<<< HEAD
import edu.fourmen.vo.Criteria;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO2;
=======
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO;
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)

@Repository
public class BoardItemDAO {
	
	@Autowired(required=true)
	SqlSession sqlSession;
	
	private static final String efdb = "edu.fourmen.mapper.boardItemMapper";
	
	public List<BoardItemVO> selectAll(BoardItemVO vo) {
		return sqlSession.selectList(efdb+".selectAll",vo);
		
	}
		
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request) {
		return sqlSession.insert(efdb+".boarditemswrite",vo);
	}
	
	public BoardItemVO selectitem(int item_idx) {
		return sqlSession.selectOne(efdb+".selectitem",item_idx);
	}
	
<<<<<<< HEAD
	public int totalcount() {
		int result = sqlSession.selectOne(efdb+".totalcount");
		return result;
	}
=======
	public int totalCount(PageMaker pm) {
		int result = sqlSession.selectOne(efdb+".totalCount",pm);
		return result;
	}
	
	public int itemmodify(BoardItemVO vo) {
		int result = sqlSession.update(efdb+".itemmodify",vo);
		return result;
	}
	public int itemdelete(BoardItemVO vo) {
	
		return sqlSession.delete(efdb+".itemdelete",vo);
		
	}
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)
}
