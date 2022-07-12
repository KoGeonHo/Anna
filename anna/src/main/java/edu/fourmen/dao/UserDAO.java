package edu.fourmen.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	public int emailChk(String user_email) {

		int result = sqlSession.selectOne("edu.fourmen.mapper.userMapper.emailChk",user_email);
		
		return result;
	}

	
	public int joinS1(UserVO vo) {

		int result = sqlSession.insert("edu.fourmen.mapper.userMapper.joinS1",vo);
		
		return result;
	}
}
