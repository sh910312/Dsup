package com.dsup.chat.service;

import com.dsup.chat.UsersVO;

public interface UsersService {

	// 회원가입
	void insertUsers(UsersVO vo);
	
	// 로그인
	void login(UsersVO vo);
	
	// 로그아웃
	void logout(UsersVO vo);
	

	
	
}
