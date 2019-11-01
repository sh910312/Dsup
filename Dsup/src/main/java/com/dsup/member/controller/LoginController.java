package com.dsup.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String login(@ModelAttribute("member") MemberVO vo, HttpSession session) {
		//model.addAttribute("userVO", vo); 를 자동으로해준다
		MemberVO member = memberService.login(vo);
		if(member == null) {
			return "index";
		} else {
			//세션에 저장 목록으로 페이지이동
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getUserId());
			return "redirect:main";
		}
	}
	@RequestMapping("main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("index")
	public String index() {
		return "index";
	}
	
	
	//로그아웃처리
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();	//세션무효화
		return "redirect:index";
	}
}
