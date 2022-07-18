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

	
	public int join(UserVO vo) {

		int result = sqlSession.insert("edu.fourmen.mapper.userMapper.join",vo);
		
		return result;
		
		
	}
	
	public UserVO login(UserVO vo) {

		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.login",vo);
		
	}
	
	public void updateKakaoAuthKey(UserVO vo) {
		
		sqlSession.selectOne("edu.fourmen.mapper.userMapper.updateKakaoAuthKey",vo);
		
	}


	public UserVO getUserInfo(int uidx) {
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getUsetInfo",uidx);
		
	}
}
