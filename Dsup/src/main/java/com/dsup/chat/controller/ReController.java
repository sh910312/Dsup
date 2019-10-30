package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ReVO;
import com.dsup.chat.service.ReService;

@Controller
public class ReController {

	@Autowired ReService reService;
	
	// 댓글 등록
	@RequestMapping("/Reform")
	public String insertReForm() {
		
		return "chat/keyword/getSearch";
	}
	
	// 등록처리
	@RequestMapping("/insertRe")
	public String insertRe(ReVO vo, HttpServletRequest request, HttpSession session) {
	
		vo.setUserId("test"); // 로그인 세션 살려놓기 ( 1 = 관리자)
		
		reService.insertRe(vo);
		return "redirect:/getSearch?searchId="+ vo.getSearchId(); // 이쪽으로 이동 // redirech 안에는 requestmapping 내용을 넣는다
	}
	
	
	/*
	 * //전체 조회
	 * 
	 * @RequestMapping("/ReMap") public String ReMap(ReVO vo, Model model) {
	 * 
	 * model.addAttribute("reList", reService.ReMap(vo));
	 * 
	 * return "chat/keyword/getsearch"; }
	 */
	
	
}