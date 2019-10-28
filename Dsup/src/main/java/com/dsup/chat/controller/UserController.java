package com.dsup.chat.controller;

import org.springframework.web.bind.annotation.RequestMapping;

public class UserController {

	// 회원가입
	@RequestMapping("/insertUsers")
	public String insertSearchForm() {

		return "chat/user/insertUsers";
	}
	
	// 로그인
	@RequestMapping("/login")
	public String login() {
		
		return "chat/user/login";
	}
	
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout() {
		
		return "chat/user/logout";
	}
	
	
	

}
