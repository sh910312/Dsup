package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.ChatVO;

public interface ChatService {
	
	// 채팅전송
	int insertChat(ChatVO vo);
	// 채팅목록
	List<Map<String, Object>> ChatMap(ChatVO vo);
	List<ChatVO> ChatList(ChatVO vo);
	//상세보기
	ChatVO getChat(ChatVO vo);
}
