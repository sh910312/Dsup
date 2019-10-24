package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.ChatVO;
import com.dsup.chat.service.ChatService;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired ChatDAOMybatis chatDAOmybatis;
	
	
	//채팅 전송
	@Override
	public void insertChat(ChatVO vo) {
		// TODO Auto-generated method stub
		chatDAOmybatis.insertChat(vo);
	}

	//채팅목록
	@Override
	public List<Map<String, Object>> getChatMap(ChatVO vo) {
		// TODO Auto-generated method stub
		return chatDAOmybatis.getChatMap(vo);
	}



}
