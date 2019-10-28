package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.SearchVO;
import com.dsup.chat.service.SearchService;

@Service
public class SearchServiceImpl implements SearchService {

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)
	
	
	@Autowired
	SearchDAOMybatis searchDAOMybatis;

	// 등록
	@Override
	public void insertSearch(SearchVO vo) {
		// TODO Auto-generated method stub
		searchDAOMybatis.insert(vo);
	}
	
	// 검색
	@Override
	public void search(SearchVO vo) {
		// TODO Auto-generated method stub
		searchDAOMybatis.search(vo);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 상세조회
	@Override
	public SearchVO get(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.get(vo);
	}
	// 전체조회
	@Override
	public List<SearchVO> getList(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.getList();
	}
	// 검색
	@Override
	public List<Map<String, Object>> getMap(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.getMap(vo);
	}

}
