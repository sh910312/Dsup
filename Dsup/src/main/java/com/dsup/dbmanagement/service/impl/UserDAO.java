package com.dsup.dbmanagement.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.UserSchemaVO;

@Repository
public class UserDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mybatis;
	
	//삭제
	public int deleteUser(UserVO dto) {
		return mybatis.delete("UserDAO.deleteUser", dto);
	}
	
	//삭제
	public int deleteUserDrop(UserVO dto) {
		return mybatis.delete("UserDAO.deleteUserDrop", dto);
	}
		
	//생성
	public int insertUser(UserVO dto) {
		return mybatis.insert("UserDAO.createUser", dto);
		
	}
	//리스트
	public List<Map<String, Object>> userList(UserVO vo) {
		System.out.println(vo);
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
	

	//id중복 체크
	public int checkOverId(String id) {
		return 0;
	}

	// 윤정 목록조회
	public List<UserVO> getUserSchema(String userId) {
		return mybatis.selectList("UserDAO.getUserSchema", userId);
	}
}
