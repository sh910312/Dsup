package com.dsup.dbmanagement.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.messge.Coolsms;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.dbmanagement.service.UserService;





@Controller
public class UserController {

	@Autowired UserService userService;
	@Autowired StorageService storageService;
	
	//목록 페이지로 이동
	@RequestMapping("userList")
	public String userList(UserVO vo, Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		model.addAttribute("tableSpaceList",storageService.getStorageList(userId));
		return "dbmanagement/user/userList";
	}
	
	//목록조회
	@RequestMapping(value="/users", method=RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> userList(HttpSession session, Model model, UserVO vo){
		vo.setUser((String)session.getAttribute("userId")); //나중에 주석풀어야함  
		return userService.userList(vo);
	}
	
	//등록페이지 
	@RequestMapping("/userCreateForm")
	public String userCreateForm(Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId"); //임시로 test 쓰고있음 나중에 주석 풀어야함
		model.addAttribute("tableSpaceList",storageService.getStorageList(userId));
		return "dbmanagement/user/userCreate";
	}

	//등록처리 
	@RequestMapping(value="/users"
			,method=RequestMethod.POST
			,consumes="application/json" )
	@ResponseBody
	public Map userCreate(@RequestBody UserVO vo, Model model, HttpSession session) {
		
		vo.setUser((String)session.getAttribute("userId")); //나중에 주석풀어야함
		if(vo.getDefaultTableSpace() == null) {
		   vo.setDefaultTableSpace("USERS");
		}
		System.out.println(vo.getDefaultTableSpace());
		userService.insertUser(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("user", vo);
		return map;
	}
	
	//id 중복체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(UserVO vo) {
		return userService.idCheck(vo);
	}
	
	
	
	

	
	//삭제
	@RequestMapping(value="/users/{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map deleteUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setUser(id);
		userService.deleteUser(vo);
		return Collections.singletonMap("result", true);
		
	}
	
	//단건조회
	@RequestMapping(value="/user/{id}", method=RequestMethod.GET)
	@ResponseBody
	public UserVO getUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setId(id);
		return userService.getUser(vo);
	}

	//업데이트
	@RequestMapping(value="/users", method=RequestMethod.PUT, consumes="application/json" )
	@ResponseBody
	public UserVO updateUser(@RequestBody UserVO vo, Model model) {
		/*
		 * if(vo.getDefaultTableSpace() == null || vo.getTemporaryTableSpace() == null)
		 * { vo.setDefaultTableSpace("USERS"); vo.setTemporaryTableSpace("TEMP"); }
		 */
		userService.updateUser(vo);
		return vo;
	}
	
}