package edu.fourmen.service;

import java.util.List;

import edu.fourmen.vo.QnAVO;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.UserVO;

public interface AdminService {

	List<UserVO> getUserList();

	List<QnAVO> getQnaList();

	List<ReportVO> getReportList();
	
	List<ReportVO> getReportView(int ridx);

	void toggleAdmin(UserVO vo);
	
	int reportapply(int ridx);

}
