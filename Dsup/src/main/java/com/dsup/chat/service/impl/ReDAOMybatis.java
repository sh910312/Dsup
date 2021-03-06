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
	// 댓글 페이징
	public List<Map<String, Object>> ReMap(ReVO vo){
		return mybatis.selectList("ReDAO.reMap", vo);
	}
	
	// 페이징 전체검색
	public int RePagingList(ReVO vo) {
		return mybatis.selectOne("ReDAO.repageList", vo);
	}
	// 댓글 삭제
	public void delete(ReVO vo) {
		mybatis.delete("ReDAO.deleteRe", vo);
	}
	
	// 상세보기
	public ReVO getRe(ReVO vo) {
		return mybatis.selectOne("ReDAO.getRe",vo);
	}
	
	// 수정하기
	public void update(ReVO vo) {
		mybatis.update("ReDAO.updateRe", vo);
	}
	
	
	
}
