package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.Paging;
import com.dsup.chat.ReVO;

public interface ReService {

	// 댓글등록
	void insertRe(ReVO vo);
	
	// 댓글 전체조회
	List<ReVO> ReList(ReVO vo);
	
	//검색 + 페이징
	List<Map<String, Object>>ReMap(ReVO vo, Paging paging);
	
	// 댓글 삭제
	void deleteRe(ReVO vo);
	
	// 상세보기
	ReVO getRe(ReVO vo);
	
	// 댓글 수정 
	void updateRe(ReVO vo);
	
}
