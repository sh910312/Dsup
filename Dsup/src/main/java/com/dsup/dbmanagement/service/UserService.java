package com.dsup.dbmanagement.service;

import java.util.List;
import java.util.Map;

import com.dsup.dbmanagement.UserVO;
//인터페이스 구현
public interface UserService {

	//등록
	int insertUser(UserVO vo);
	
	//목록
	public List<Map<String,Object>> userList(UserVO vo);
	
	//id중복체크
	int userIdCheck(String user_id);

	//삭제
	public int deleteUser(UserVO vo);
	
	//수정
	public int updateUser(UserVO vo);
	
	//단건조회
	public UserVO getUser(UserVO vo);

	//스키마 생성
	public int insertSchemaTb(UserSchemaVO dto);
	
	
}
