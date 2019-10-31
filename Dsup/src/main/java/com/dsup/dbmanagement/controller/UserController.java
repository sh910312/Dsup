package com.dsup.dbmanagement.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.dbmanagement.service.UserService;
import com.dsup.dbmanagement.service.impl.UserServiceImpl;

@Controller
public class UserController {

	@Autowired UserService userService;
	@Autowired StorageService storageService;
	
	//전체조회 
	@RequestMapping("userList")
	public String userList(UserVO vo, Model model) {
		model.addAttribute("userList", userService.userList(vo));
		return "dbmanagement/user/userList";
	}
	//등록폼
	@RequestMapping("/userCreateForm")
	public String userCreateForm(Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		model.addAttribute(storageService.getStorageList(userId));
		return "dbmanagement/user/userCreate";
	}

	//등록
	@RequestMapping(value="/users"
			,method=RequestMethod.POST
			,consumes="application/json" )
	@ResponseBody
	public Map userCreate(@RequestBody UserVO vo, Model model) {
		//model.addAttribute("list", storageService.getStorageList(""));
		model.addAttribute("list", userService.getUser(vo));
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
	
}