package com.dsup.chat.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.UsersVO;
import com.dsup.chat.service.UsersService;

@Service
public class UsersServiceImpl implements UsersService {

	// 회원가입(insertUsers)

	@Autowired
	UsersDAOMybatis usersDAOMybatis;

	// 회원가입
	@Override
	public void insertUsers(UsersVO vo) {
		// TODO Auto-generated method stub
		usersDAOMybatis.insertUsers(vo);

	}

	// 로그인
	@Override
	public void login(UsersVO vo) {
		// TODO Auto-generated method stub

	}
	// 로그아웃
	@Override
	public void logout(UsersVO vo) {
		// TODO Auto-generated method stub

	}

}
