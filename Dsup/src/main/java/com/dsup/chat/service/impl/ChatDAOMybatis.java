package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.chat.ChatVO;

@Repository
public class ChatDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;

	// 채팅전송
	public void insertChat(ChatVO vo) {
		System.out.println("mybatis Proc 채팅전송 실행");
		mybatis.insert("ChatDAO.insertChatProc", vo);
	}

	// 채팅목록
	public List<Map<String, Object>> getChatMap(ChatVO vo) {
		return mybatis.selectList("ChatDAO.getChatMap", vo);
	}

}
