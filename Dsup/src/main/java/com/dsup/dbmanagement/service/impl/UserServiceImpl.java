package com.dsup.dbmanagement.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired UserDAOMybatis userDAO;

	@Override
	public void insertUser(UserVO vo) {
		userDAO.insertUser(vo);
	}

	@Override
	public List<Map<String, Object>> userList(UserVO vo) {
		return userDAO.userList(vo);
	}
	
	

}
