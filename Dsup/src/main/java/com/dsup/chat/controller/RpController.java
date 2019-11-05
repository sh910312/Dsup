package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ReVO;
import com.dsup.chat.RpVO;
import com.dsup.chat.SearchVO;
import com.dsup.chat.service.ReService;
import com.dsup.chat.service.RpService;
import com.dsup.chat.service.SearchService;
import com.dsup.member.MemberVO;

@Controller
public class RpController {

	@Autowired
	RpService rpService;

	@Autowired
	ReService reService;

	@Autowired
	SearchService searchService;

	// 신고하기
	@RequestMapping("/inRp")
	public String inRp() {
		return "chat/report/inRp";
	}

	// 상세조회 -- 11/05 다시 합니다 다시 까먹음
	@RequestMapping("getRp")
	public String getRp(HttpServletRequest request, Model model, SearchVO svo, ReVO rvo, RpVO rpvo) {
		
		model.addAttribute("rp", rpService.RpList(rpvo));
		model.addAttribute("search", searchService.getSearch(svo));
		model.addAttribute("report", reService.ReList(rvo));
		
		
		return "";
	}

	// 신고하기처리
	@RequestMapping("/RpOk")
	public String insertSearch(RpVO rpvo, ReVO revo, HttpServletRequest request, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		rpvo.setUserId(member.getUserId());

		// 밑에는 고쳐야됨

		rpService.inRp(rpvo);

		return "redirect:/getreId?reId=" + revo.getReId(); // 이쪽으로 이동 // redirech 안에는 requestmapping 내용을 넣는다
	}

}