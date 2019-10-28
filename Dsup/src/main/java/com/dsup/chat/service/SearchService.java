package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.SearchVO;

public interface SearchService {

	// 등록
	void insertSearch(SearchVO vo);

	// 전체조회
	List<SearchVO> SearchList(SearchVO vo);

	// 상세조회
	SearchVO getSearch(SearchVO vo);

	// 검색
	List<Map<String, Object>> SearchMap(SearchVO vo);
	
	// 삭제 
	void deleteSearch(SearchVO vo);
	
	// 선택삭제
	void deleteSearchList(SearchVO vo);
}
