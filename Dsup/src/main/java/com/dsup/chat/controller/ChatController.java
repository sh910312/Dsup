package com.dsup.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.ChatVO;
import com.dsup.chat.service.ChatService;

@Controller
public class ChatController {

	@Autowired ChatService chatService;
	// 채팅 메인화면
	@RequestMapping("chatMain")
	public String chatList(ChatVO vo, Model model) {
		return "chat/chatMain";
	}
	
	
	
}
