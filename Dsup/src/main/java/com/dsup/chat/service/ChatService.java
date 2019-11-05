package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.ChatVO;

public interface ChatService {
	
	// 채팅 전송
	void insertChat(ChatVO vo);
	// 채팅목록
	List<Map<String, Object>> ChatMap(ChatVO vo);

}
