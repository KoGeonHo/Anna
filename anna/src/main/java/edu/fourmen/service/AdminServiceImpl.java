package edu.fourmen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.AdminDAO;
import edu.fourmen.vo.QnAVO;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	AdminDAO adminDAO;
	
	@Override
	public List<UserVO> getUserList() {

		return adminDAO.getUserList();
	
	}

	@Override
	public List<QnAVO> getQnaList() {
		
		return adminDAO.getQnaList();
		
	}

	@Override
	public List<ReportVO> getReportList() {
		
		return adminDAO.getReportList();
		
	}

	@Override
	public void toggleAdmin(UserVO vo) {

		adminDAO.toggleAdmin(vo);
		
	}

	@Override
	public List<ReportVO> getReportView(int ridx) {
		
		return adminDAO.getReportView(ridx);
	}

	@Override
	public int reportapply(int ridx) {
		
		return adminDAO.reportapply(ridx);
		
	}
	
	
	
}
