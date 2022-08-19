package edu.fourmen.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.QnAVO;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.UserVO;

@Repository
public class AdminDAO {
	@Autowired
	SqlSession sqlSession;

	public List<UserVO> getUserList() {

		return sqlSession.selectList("edu.fourmen.mapper.adminMapper.selectadminUser");
	}
	
	public List<QnAVO> getQnaList() {

		return sqlSession.selectList("edu.fourmen.mapper.adminMapper.selectadminQna");
	}

	public List<ReportVO> getReportList() {
		
		return sqlSession.selectList("edu.fourmen.mapper.adminMapper.getReportList");
		
	}

	public void toggleAdmin(UserVO vo) {

		sqlSession.update("edu.fourmen.mapper.adminMapper.toggleAdmin",vo);
		
	}
	
}
