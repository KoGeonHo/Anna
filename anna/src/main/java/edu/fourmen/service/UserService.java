package edu.fourmen.service;

import java.util.HashMap;

import edu.fourmen.vo.UserVO;

public interface UserService {
	int emailChk(String user_email);
	int join(UserVO vo);
	UserVO login(UserVO vo);
	String getClient_id();
	String getRedirect_uri();
	HashMap<String, Object> getAccessToken(String code);
	HashMap<String, Object> getUserInfo(String access_Token);
}
