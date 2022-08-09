package edu.fourmen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fourmen.dao.CustomerDAO;
import edu.fourmen.vo.QnAVO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	CustomerDAO customerDAO;

	@Override
	public List<QnAVO> getQnAList(int uidx) {
		
		return customerDAO.getQnAList(uidx);
	}

	@Override
	public int QnAWrite(QnAVO vo) {
		
		return customerDAO.QnAWrite(vo);
	}

	@Override
	public QnAVO QnAView(int qidx) {
		
		return customerDAO.QnAView(qidx);
	}

	@Override
	public int QnADel(int qidx) {
		
		return customerDAO.QnADel(qidx);
	}
	
}
