package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.chat.SearchVO;

@Repository
public class SearchDAOMybatis { // (p.513)

	@Autowired
	SqlSessionTemplate mybatis;

	// 등록
	public void insert(SearchVO vo) {
		mybatis.insert("SearchDAO.insert", vo);
	}

	// 단건조회
	public SearchVO get(SearchVO vo) {
		return mybatis.selectOne("SearchDAO.get", vo);
	}

	// 전체조회
	public List<SearchVO> getList() {
		return mybatis.selectList("SearchDAO.getList");
	}

	public List<Map<String, Object>> getMap(SearchVO vo) {
		return mybatis.selectList("SearchDAO.getMap", vo);
	}

}
