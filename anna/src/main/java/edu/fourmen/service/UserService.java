package edu.fourmen.service;

import edu.fourmen.vo.UserVO;

public interface UserService {
	int emailChk(String user_email);
	int join(UserVO vo);
	UserVO login(UserVO vo);
}
