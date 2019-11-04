package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.Paging;
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
	public List<Map<String, Object>> SearchMap(SearchVO vo, Paging paging) {
		// TODO Auto-generated method stub

		// 페이지번호 파라미터
		if (paging.getPage() == null) {
			paging.setPage(1);
		}

		paging.setPageUnit(9); // 게시글 갯수
		paging.setPageSize(2); // 하단 페이지 목록 수

		// 전체 건수
		paging.setTotalRecord(searchDAOMybatis.PagingList(vo));

		// 시작/마지막 레코드 번호
		vo.setFirst(paging.getFirst());
		vo.setLast(paging.getLast());

		return searchDAOMybatis.SearchMap(vo);
	}

	// 삭제
	@Override
	public void deleteSearch(SearchVO vo) {
		searchDAOMybatis.deleteSearch(vo);
	}

	// 선택 삭제
	@Override
	public void deleteSearchList(SearchVO vo) {
		searchDAOMybatis.deleteSearchList(vo);
	}

	// 수정
	@Override
	public void updateSearch(SearchVO vo) {
		searchDAOMybatis.updateSearch(vo);
	}

}
