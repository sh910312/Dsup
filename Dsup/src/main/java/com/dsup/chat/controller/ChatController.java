package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ChatVO;
import com.dsup.chat.service.ChatService;
import com.dsup.member.MemberVO;

@Controller
public class ChatController {

	@Autowired ChatService chatService;
	
	// 채팅 메인화면
	@RequestMapping("chatMain")
	public String chatList(ChatVO vo, Model model) {
		return "chat/chatMain";
	}
	
	
	// 채팅 등록 처리
	@RequestMapping("inchat")
	public String inchat(ChatVO vo, HttpServletRequest request, HttpSession session) {
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		vo.setUserId(member.getUserId());

		System.out.println(vo);
		
		chatService.insertChat(vo);
		return "redirect:/chatMain";
	}
	
	
	
	// 채팅 등록 처리
	
	
	
	
	
}
