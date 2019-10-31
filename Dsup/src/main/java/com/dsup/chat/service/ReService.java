package com.dsup.chat.service;

import java.util.List;
import java.util.Map;

import com.dsup.chat.Paging;
import com.dsup.chat.ReVO;

public interface ReService {

	// 댓글등록
	void insertRe(ReVO vo);
	// 댓글 리스트 + 페이징
	List<ReVO> ReList(ReVO vo);
	List<Map<String, Object>>ReMap(ReVO vo, Paging rpaging);
	
	// 댓글 삭제
	

	// 댓글?
	
	
}
