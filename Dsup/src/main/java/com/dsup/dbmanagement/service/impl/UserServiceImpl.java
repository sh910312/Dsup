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

	public int idCheck(UserVO vo) {
		UserVO user = userDAO.getUser(vo);
		if(user == null)
			
		return 0;
		else{
			return 1;
		}
	}
	
	@Override
	public int deleteUser(UserVO dto) {
		userDAO.deleteUserDrop(dto);
		return userDAO.deleteUser(dto);
		
	}

	@Override
	public int updateUser(UserVO dto) {
		return userDAO.updateUser(dto);
	}

	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}

	/*
	 * @Override public UserVO reservedWords(UserVO vo) { return
	 * userDAO.getUser(vo); }
	 */

	@Override
	public List<UserVO> getUserSchema(String userId) {
		// 윤정 목록조회
		return userDAO.getUserSchema(userId);
	}

	@Override
	public int scChk(String reservedWords) {
		if(userDAO.scChk(reservedWords) == null)
			return 1;
		else
			return 0;
		
	}



}
