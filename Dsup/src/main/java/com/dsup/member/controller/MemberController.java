package com.dsup.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dsup.member.MemberVO;
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
	public String MyInfo(HttpServletRequest request, Model model, HttpSession session) {
		MemberVO vo = new MemberVO();
		vo.setUserId((String)session.getAttribute("userId"));
		
		model.addAttribute("member", memberService.getMember(vo));
		return "member/myInfo";
	} 
	
	//정보변경으로 이동
	@RequestMapping("/modify")
	public String Modify() {
		return "member/modify";
	} 
}
