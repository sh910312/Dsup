package com.dsup.dbmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.UserService;

@Controller
public class UserController {

	@Autowired UserService userService;
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
	//등록
	@RequestMapping("/userCreate")
	public String userCreate(UserVO vo, Model model) {
		return "redirect:userList";
	}
	
}
