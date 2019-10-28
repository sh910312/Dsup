package com.dsup.dbmanagement.controller;

import java.util.HashMap;
import java.util.Map;

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
	public String userCreateForm() {
		return "dbmanagement/user/userCreate";
	}

	//id중복체크
	@RequestMapping(value="/checkSingup", method=RequestMethod.POST)
	public @ResponseBody String AjaxView(  
	        @RequestParam("id") String id){
	String str = "";
	int idcheck = userService.userIdCheck(id);
	if(idcheck==1){ //이미 존재하는 계정
		str = "NO";	
	}else{	//사용 가능한 계정
		str = "YES";	
	}
	return str;
	}
	//등록
	@RequestMapping(value="/users"
			,method=RequestMethod.POST
			,consumes="application/json" )
	@ResponseBody
	public Map userCreate(@RequestBody UserVO vo, Model model) {
		model.addAttribute("list", storageService.getStorageList(""));
		if(vo.getDefaultTableSpace() == null || vo.getTemporaryTableSpace() == null) {
		   vo.setDefaultTableSpace("USERS");
		   vo.setTemporaryTableSpace("TEMP");
		}
		userService.insertUser(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("user", vo);
		return map;
	}
	

}