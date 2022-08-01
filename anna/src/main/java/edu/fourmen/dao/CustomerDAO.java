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
		// TODO Auto-generated method stub
		return sqlSession.selectList("edu.fourmen.mapper.customerMapper.getQnAList",uidx);
	}
	
	
}
