package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.SearchVO;

public interface SearchService {

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)
	
	// 등록
	void insertSearch(SearchVO vo);

	// 상세조회
	SearchVO get(SearchVO vo);

	// 전체조회
	List<SearchVO> getList(SearchVO vo);

	// 검색
	List<Map<String, Object>> getMap(SearchVO vo);

}
