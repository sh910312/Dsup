package com.dsup.chat.service.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.chat.UsersVO;

@Repository
public class UsersDAOMybatis { // (p.513)

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)

	@Autowired
	SqlSessionTemplate mybatis;

	// 회원가입
	// UsersDAO는 mapper.xml에 있는 DAO를 가져오는것
	public void insertUsers(UsersVO vo) {
		mybatis.insert("UsersDAO.insertUsers", vo);
	}

	
	// 로그인
	public void login(UsersVO vo) {
		
	}
	
	
	
	// 로그아웃
	public void logout(UsersVO vo) {
		
	}
}
