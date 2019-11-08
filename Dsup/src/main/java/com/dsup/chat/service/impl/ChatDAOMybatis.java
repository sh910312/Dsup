package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.chat.ChatVO;

@Repository
public class ChatDAOMybatis {

	@Resource(name = "sqlSessionTemplate")
	SqlSessionTemplate mybatis;

	// 채팅전송
	public int insertChat(ChatVO vo) {
		return mybatis.insert("ChatDAO.insertChat", vo);
	}

	// 상세보기
	public ChatVO getChat(ChatVO vo) {
		return mybatis.selectOne("ChatDAO.getChat", vo);
	}

	// 채팅목록
	public List<Map<String, Object>> ChatMap(ChatVO vo) {
		return mybatis.selectList("ChatDAO.chatMap", vo);
	}
	// 채팅목록2
	public List<ChatVO> ChatList() {
		return mybatis.selectList("ChatDAO.ChatList");
	}

}
