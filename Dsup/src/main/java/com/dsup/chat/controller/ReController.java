package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ReVO;
import com.dsup.chat.service.ReService;
import com.dsup.chat.service.SearchService;
import com.dsup.member.MemberVO;

@Controller
public class ReController {

	@Autowired
	ReService reService;
	
	@Autowired
	SearchService searchService;
	
	// 댓글 등록
	@RequestMapping("/Reform")
	public String insertReForm() {

		return "chat/keyword/getSearch";
	}

	// 등록처리
	@RequestMapping("/insertRe")
	public String insertRe(ReVO vo, HttpServletRequest request, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		vo.setUserId(member.getUserId()); // 로그인 세션 살려놓기 ( 1 = 관리자)
		reService.insertRe(vo);
		return "redirect:/getSearch?searchId=" + vo.getSearchId(); // 이쪽으로 이동 // redirech 안에는 requestmapping 내용을 넣는다
	}

	// 수정처리
	@RequestMapping("/updateRe")
	public String updateRe(ReVO rvo, HttpServletRequest request, HttpSession session) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		rvo.setUserId(member.getUserId());
		
		reService.updateRe(rvo);
		System.out.println(rvo);
		
		return "redirect:getSearch?searchId=" + rvo.getSearchId();
	}

	// 삭제
	@RequestMapping("/delRe")
	public String deleteRe(ReVO vo) {

		reService.deleteRe(vo);

		return "redirect:getSearch?searchId=" + vo.getSearchId();
		//return "redirect:getSearch?searchId=" + vo.getSearchId();
	}

}
