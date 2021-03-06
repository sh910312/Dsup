package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.chat.SearchVO;

@Repository
public class SearchDAOMybatis { // (p.513)

	@Resource(name = "sqlSessionTemplate")
	SqlSessionTemplate mybatis;

	// 등록
	// SearchDAO는 mapper.xml에 있는 DAO를 가져오는것
	public void insert(SearchVO vo) {
		mybatis.insert("SearchDAO.insertSearch", vo);
	}

	// 수정
	public void updateSearch(SearchVO vo) {
		mybatis.update("SearchDAO.updateSearch", vo);
	}

	// 전체 검색
	public List<SearchVO> searchList() {
		return mybatis.selectList("SearchDAO.searchList");

	}

	// 상세 조회
	public SearchVO getSearch(SearchVO vo) {
		return mybatis.selectOne("SearchDAO.getSearch", vo);
	}

	// 검색
	public List<Map<String, Object>> SearchMap(SearchVO vo) {
		return mybatis.selectList("SearchDAO.SearchMap", vo);
	}

	// 선택 삭제
	public void deleteSearchList(SearchVO vo) {
		mybatis.delete("SearchDAO.deleteSearchList", vo);
	}

	// 삭제
	public void deleteSearch(SearchVO vo) {
		mybatis.delete("SearchDAO.deleteSearch", vo);
	}

	// 페이징 전체검색
	public int PagingList(SearchVO vo) {
		return mybatis.selectOne("SearchDAO.pageList", vo);
	}

}
