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
		// TODO Auto-generated method stub
		return customerDAO.getQnAList(uidx);
	}
	
}
