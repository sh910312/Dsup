package com.dsup.dbmanagement.service.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.UserVO;

@Repository
public class UserDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//삭제
	public int deleteUser(UserVO dto) {
		return mybatis.delete("UserDAO.deleteUser", dto);
	}
	//생성
	public int insertUser(UserVO dto) {
		return mybatis.insert("UserDAO.createUser", dto);
		
	}
	//리스트
	public List<Map<String, Object>> userList(UserVO vo) {
		return mybatis.selectList("UserDAO.userList", vo);
	}
	//수정
	public int updateUser(UserVO dto) {
		return mybatis.update("UserDAO.updateUser", dto);
	}
	
	//단건조회
	public UserVO getUser(UserVO vo) {
		return mybatis.selectOne("UserDAO.getUser", vo);
	}

	

}
