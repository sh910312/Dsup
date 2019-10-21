package com.dsup.dbmanagement.service;

import java.util.List;
import java.util.Map;

import com.dsup.dbmanagement.UserVO;
//인터페이스 구현
public interface UserService {

	//등록
	void insertUser(UserVO vo);
	
	//목록
	public List<Map<String,Object>> userList(UserVO vo);
}
