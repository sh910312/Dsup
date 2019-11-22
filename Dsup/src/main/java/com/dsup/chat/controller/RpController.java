package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ChatVO;
import com.dsup.chat.ReVO;
import com.dsup.chat.RpVO;
import com.dsup.chat.SearchVO;
import com.dsup.chat.service.ChatService;
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

	@Autowired
	ChatService chatService;
	

	// 신고
	@RequestMapping("getRp")
	public String getRpsearch(HttpSession session,HttpServletRequest request, Model model, SearchVO svo, ReVO revo, RpVO rpvo, ChatVO cvo) {
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		rpvo.setUserId(member.getUserId());
		// 0번 게시글
		if (svo.getSearchId() != 0) {
			model.addAttribute("rpType", 0);
			model.addAttribute("search", searchService.getSearch(svo));
			rpvo.setRpType(0);
			rpvo.setBoardNum(svo.getSearchId());
			model.addAttribute("checkRp", rpService.checkRp(rpvo));
		// 1번 댓글
		}else if(revo.getReId() != 0) {
			model.addAttribute("rpType", 1);
			model.addAttribute("re",reService.getRe(revo));
			rpvo.setRpType(1);
			rpvo.setBoardNum(revo.getReId());
			model.addAttribute("checkRp", rpService.checkRp(rpvo));
			System.out.println(revo);
		// 2번 채팅신고	
		}else if(cvo.getChatId() != 0) {
			model.addAttribute("rpType", 2);
			model.addAttribute("chat",chatService.getChat(cvo));
			rpvo.setRpType(2);
			rpvo.setBoardNum(cvo.getChatId());
			model.addAttribute("checkRp", rpService.checkRp(rpvo));
		}
		return "chat/report/inRp";
	}

	// 신고처리
	@RequestMapping("/RpOk")
	public String insertSearch(RpVO vo, HttpServletRequest request, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		vo.setUserId(member.getUserId());
		
		rpService.inRp(vo);
		return "redirect:/SearchMap"; // 이쪽으로 이동 // redirech 안에는 requestmapping 내용을 넣는다
	}

}