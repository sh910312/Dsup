package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.chat.SearchVO;

@Repository
public class SearchDAOMybatis { // (p.513)

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)

	@Autowired
	SqlSessionTemplate mybatis;

	// 등록
	// SearchDAO는 mapper.xml에 있는 DAO를 가져오는것
	public void insert(SearchVO vo) {
		mybatis.insert("SearchDAO.insertSearch", vo);
	}
	
	// 상세조회
	public SearchVO get(SearchVO vo) {
		return mybatis.selectOne("SearchDAO.get", vo);
	}

	// 전체조회
	public List<SearchVO> getList() {
		return mybatis.selectList("SearchDAO.getList");
	}

	// 검색
	public List<Map<String, Object>> getMap(SearchVO vo) {
		return mybatis.selectList("SearchDAO.getMap", vo);
	}

}
