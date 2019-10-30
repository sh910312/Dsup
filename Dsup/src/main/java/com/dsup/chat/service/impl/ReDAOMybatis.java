package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.chat.ReVO;

@Repository
public class ReDAOMybatis {

	@Resource(name = "sqlSessionTemplate")
	SqlSessionTemplate mybatis;
	// 등록
	// SearchDAO는 mapper.xml에 있는 DAO를 가져오는것
	public void insert(ReVO vo) {
		mybatis.insert("ReDAO.insertRe", vo);
	}
	// 댓글 리스트
	public List<ReVO> reList() {
		return mybatis.selectList("ReDAO.reList");
	}
	public List<Map<String, Object>> ReMap(ReVO vo){
		return mybatis.selectList("ReDAO.reMap", vo);
	}
	
	
}
