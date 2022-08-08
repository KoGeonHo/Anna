package edu.fourmen.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
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
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getUserInfo",uidx);
		
	}


	public int userInfoMod(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.userInfoMod",vo);
		
	}


	public int updateInterested(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.updateInterested",vo);
		
	}


	public int updateLocation(UserVO vo) {

		return sqlSession.update("edu.fourmen.mapper.userMapper.updateLocation",vo);
		
	}


	public String getLocation(int uidx) {

		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getLocation",uidx);
		
	}


	public List<BoardItemVO> getInterestedItem(List<String> interested) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getInterestedItem",interested);
		
	}


	public List<UserVO> neighborList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.neighborList",uidx);
		
	}


	public List<BoardVO> myTownCommunityList(String location_auth) {
		
		String[] ArrayLocation = location_auth.split(",");
		
		List<String> locationList = new ArrayList<String>();
		
		for(int i = 0; i < ArrayLocation.length; i++) {
			locationList.add(ArrayLocation[i]);
		}
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.myTownCommunityList",locationList);
	}


	public UserVO keepLogin(int uidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.keepLogin",uidx);
	}
}
