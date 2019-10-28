package com.dsup.dbmanagement.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.UserService;
@RestController
public class UserRestController {

	@Autowired
	UserService userService;
	
	//목록
	@RequestMapping(value="/users", method=RequestMethod.GET)
	public List<Map<String, Object>> userList(Model model, UserVO vo){
		return userService.userList(vo);
	}
	
	//삭제
	@RequestMapping(value="/users/{id}", method=RequestMethod.DELETE)
	public Map deleteUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setId(id);
		userService.deleteUser(vo);
		return Collections.singletonMap("result", true);
		
	}
	
	//단건조회
	@RequestMapping(value="/user/{id}", method=RequestMethod.GET)
	public UserVO getUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setId(id);
		return userService.getUser(vo);
	}
	
}
