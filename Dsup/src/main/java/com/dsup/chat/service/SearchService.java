package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.SearchVO;

public interface SearchService {

	// 게시글 등록
	void insert(SearchVO vo);

	// 상세조회
	SearchVO get(SearchVO vo);

	// 목록조회
	List<SearchVO> getList(SearchVO vo);

	// 검색
	List<Map<String, Object>> getMap(SearchVO vo);

}
