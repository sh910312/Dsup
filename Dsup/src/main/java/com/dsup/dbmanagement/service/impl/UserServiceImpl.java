package com.dsup.dbmanagement.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired UserDAO userDAO;

	@Override
	public int insertUser(UserVO dto) {
		return userDAO.insertUser(dto);
	}

	@Override
	public List<Map<String, Object>> userList(UserVO vo) {
		return userDAO.userList(vo);
	}

	@Override
	public int userIdCheck(String user_id) {
		return 0;
	}

	@Override
	public int deleteUser(UserVO dto) {
		return userDAO.deleteUser(dto);
	}

	@Override
	public int updateUser(UserVO dto) {
		return userDAO.updateUser(dto);
	}

	




	
	
	
	
	
	
	/*
	 * @Override public int userIdCheck(UserVO vo) { return userDAO.insertUser(vo);
	 * }
	 */


	
	

}
