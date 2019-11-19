package com.dsup.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dsup.member.MemberVO;
import com.dsup.member.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired MemberService memberService;
	
	//로그인폼 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)	//@RequestMapping("loginForm")
	public String loginForm() {
		return "index";
	}
	
	//로그인처리
	@RequestMapping(value = "login", method = RequestMethod.POST)  //@RequestMapping("login")
	public String login(@ModelAttribute("member") MemberVO vo, HttpSession session, Model model) {
		//로컬 사용시 주석 해야될 부분 2019.11.01 - 이재문
		MemberVO member = memberService.login(vo);
		if(member == null || member.getUserType().equals("0")) {
			model.addAttribute("msg", "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
			// 윤정 : member.getUserType().equals("0") --> 탈퇴신청한 회원인경우
			return "index";
		} else {
			//세션에 저장 목록으로 페이지이동
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getUserId());
			session.setAttribute("payService", member.getPayService());
			session.setAttribute("userType", member.getUserType());
			return "redirect:iframe";
		}
		//로컬 사용시 해야될 부분 2019.11.01 - 이재문
//		session.setAttribute("userId", vo.getUserId());
//		System.out.println("Login ID : " + session.getAttribute("userId"));
//		return "main";
	}
	@RequestMapping("main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("iframe")
	public String ifame() {
		return "iframe";
	}
	
	
	//로그아웃처리
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();	//세션무효화
		return "redirect:index";
	}
}
