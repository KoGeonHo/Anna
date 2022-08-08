package edu.fourmen.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.QnAVO;

@Repository
public class CustomerDAO {
	
	@Autowired
	SqlSession sqlSession;

	public List<QnAVO> getQnAList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.customerMapper.getQnAList",uidx);
		
	}

	public int QnAWrite(QnAVO vo) {
		
		return sqlSession.insert("edu.fourmen.mapper.customerMapper.QnAWrite",vo);
		
	}

	public QnAVO QnAView(int qidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.customerMapper.QnAView",qidx);
	}
	
	
}
