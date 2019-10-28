package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.SearchVO;
import com.dsup.chat.service.SearchService;

@Service
public class SearchServiceImpl implements SearchService {

	@Autowired
	SearchDAOMybatis searchDAOMybatis;

	// 등록
	@Override
	public void insertSearch(SearchVO vo) {
		// TODO Auto-generated method stub
		searchDAOMybatis.insert(vo);
	}

	// 전체 조회
	@Override
	public List<SearchVO> SearchList(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.searchList();
	}

	// 상세조회 // 이거 다시
	@Override
	public SearchVO getSearch(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.getSearch(vo);
	}

	// 검색
	@Override
	public List<Map<String, Object>> SearchMap(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.SearchMap(vo);
	}
	
	// 삭제
	@Override
	public void deleteSearch(SearchVO vo) {
		// TODO Auto-generated method stub
		
	}
	// 선택 삭제
	@Override
	public void deleteSearchList(SearchVO vo) {
		// TODO Auto-generated method stub
		searchDAOMybatis.deleteSearchList(vo);
	}

}
