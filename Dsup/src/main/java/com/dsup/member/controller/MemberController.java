package com.dsup.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.member.service.MemberService;

@Controller
public class MemberController {

	@Autowired MemberService memberService;
	
	//메인으로 이동
	@RequestMapping("/main")
	public String Main() {
		return "member/main";
	}
	
	//내정보로 이동
	@RequestMapping("/myInfo")
	public String MyInfo() {
		return "member/myInfo";
	} 
	
	//정보변경으로 이동
	@RequestMapping("/modify")
	public String Modify() {
		return "member/modify";
	} 
}
