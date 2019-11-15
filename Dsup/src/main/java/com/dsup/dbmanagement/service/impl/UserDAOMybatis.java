package com.dsup.dbmanagement.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.UserVO;

@Repository
public class UserDAOMybatis {
	
	@Resource(name="sqlSessionTemplate") SqlSessionTemplate mybatis;
	
	//등록
	public void insertUser(UserVO vo) {
		mybatis.insert("UserDAO.createUser", vo);
	}
	//조회
	public List<Map<String, Object>> userList(UserVO vo) {
		return mybatis.selectList("UserDAO.userList", vo);
	}
	
}
