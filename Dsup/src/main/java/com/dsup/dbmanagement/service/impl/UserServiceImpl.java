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
		//중복 체크
		UserVO user = userDAO.getUser(vo);
		if(user != null) {
			return 1;
		}
		
		//오라클 예약어 체크
		String scChk = userDAO.scChk(vo.getId());
		if(scChk != null) {
			return 2;
		}
		
		return 0;
		
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
		return 0;
	}





}
