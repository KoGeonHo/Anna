package edu.fourmen.service;

import java.util.List;

import edu.fourmen.vo.QnAVO;

public interface CustomerService {

	List<QnAVO> getQnAList(int uidx);

}
