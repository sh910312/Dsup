package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.ChatVO;
import com.dsup.chat.service.ChatService;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatDAOMybatis chatDAOmybatis;

	
	@Override // 채팅 전송
	public void insertChat(ChatVO vo) {
		// TODO Auto-generated method stub
		chatDAOmybatis.insertChat(vo);
	}

	
	@Override // 채팅목록
	public List<Map<String, Object>> ChatMap(ChatVO vo) {
		// TODO Auto-generated method stub
		return chatDAOmybatis.ChatMap(vo);
	}

	@Override // 리스트
	public List<ChatVO> ChatList(ChatVO vo) {
		// TODO Auto-generated method stub
		return chatDAOmybatis.ChatList();
	}

	@Override // 상세보기
	public ChatVO getChat(ChatVO vo) {
		// TODO Auto-generated method stub
		return chatDAOmybatis.getChat(vo);
	}

}
