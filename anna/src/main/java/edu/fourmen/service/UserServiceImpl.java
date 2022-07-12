package edu.fourmen.service;

import org.springframework.beans.factory.annotation.Autowired;

import edu.fourmen.dao.UserDAO;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserDAO userDAO;
	
	@Override
	public int emailChk(String user_email) {

		int result = userDAO.emailChk(user_email);
		
		return result;
	}

}
