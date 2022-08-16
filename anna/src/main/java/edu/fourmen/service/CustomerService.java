package edu.fourmen.service;

import java.util.List;

import edu.fourmen.vo.QnAVO;

public interface CustomerService {

	List<QnAVO> getQnAList(int uidx);

	int QnAWrite(QnAVO vo);

	QnAVO QnAView(int qidx);

	int QnADel(int qidx);

	int QnAAnswer(QnAVO vo);
}
