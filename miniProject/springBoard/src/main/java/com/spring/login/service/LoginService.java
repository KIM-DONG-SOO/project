package com.spring.login.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.user.DAO.UserDAO;
import com.spring.user.vo.UserVO;


@Service
public class LoginService {
	
	@Autowired
	UserDAO userDAO;
	
	public UserVO selectOneUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.selectOneUser(userVO);
	}
	
	
}
