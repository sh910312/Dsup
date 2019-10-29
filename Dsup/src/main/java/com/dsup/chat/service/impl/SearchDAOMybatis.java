package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.chat.SearchVO;

@Repository
public class SearchDAOMybatis { // (p.513)

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)

	@Resource(name="sqlSessionTemplate")
	SqlSessionTemplate mybatis;

	// 등록
	// SearchDAO는 mapper.xml에 있는 DAO를 가져오는것
	public void insert(SearchVO vo) {
		mybatis.insert("SearchDAO.insertSearch", vo);
	}
	
	// 전체 검색
	public List<SearchVO> searchList() {
	 return	mybatis.selectList("SearchDAO.searchList");
		
	}
	// 상세 조회
	public SearchVO getSearch(SearchVO vo) {
		return mybatis.selectOne("SearchDAO.getSearch", vo);
	}
	
	// 검색
	public List<Map<String, Object>> SearchMap(SearchVO vo){
		return mybatis.selectList("SearchDAO.SearchMap", vo);
	}
	
	// 선택 삭제
	public void deleteSearchList(SearchVO vo) {
		mybatis.delete("SearchDAO.deleteSearchList", vo);
	}
	
	
	
}
