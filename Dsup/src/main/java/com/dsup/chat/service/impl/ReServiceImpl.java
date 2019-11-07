package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.Paging;
import com.dsup.chat.ReVO;
import com.dsup.chat.service.ReService;

@Service
public class ReServiceImpl implements ReService {

	@Autowired
	ReDAOMybatis reDAOMybatis;

	// 댓글 등록
	@Override
	public void insertRe(ReVO vo) {
		reDAOMybatis.insert(vo);
	}

	// 댓글 리스트
	@Override
	public List<ReVO> ReList(ReVO vo) {
		// TODO Auto-generated method stub
		return reDAOMybatis.reList();
	}

	// 댓글리스트(+페이징)
	@Override
	public List<Map<String, Object>> ReMap(ReVO vo, Paging repaging) {

		// 페이지번호 파라미터
		if (repaging.getPage() == null) {
			repaging.setPage(1);
		}

		repaging.setPageUnit(5); // 게시글 갯수
		repaging.setPageSize(2); // 하단 페이지 목록 수

		// 전체 건수
		repaging.setTotalRecord(reDAOMybatis.RePagingList(vo));

		// 시작/마지막 레코드 번호
		vo.setFirst(repaging.getFirst());
		vo.setLast(repaging.getLast());

		return reDAOMybatis.ReMap(vo);
	}

	@Override // 댓글 삭제
	public void deleteRe(ReVO vo) {
		reDAOMybatis.delete(vo);
	}

	@Override // 상세보기
	public ReVO getRe(ReVO vo) {
		// TODO Auto-generated method stub
		return reDAOMybatis.getRe(vo);
	}
	
	@Override // 댓글 수정
	public void updateRe(ReVO vo) {
		// TODO Auto-generated method stub
		reDAOMybatis.update(vo);
	}

}
