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
	public void insert(SearchVO vo) {
		// TODO Auto-generated method stub
		searchDAOMybatis.insert(vo);
	}
	// 
	@Override
	public SearchVO get(SearchVO vo) {
		// TODO Auto-generated method stub
		return searchDAOMybatis.get(vo);
	}
	// 목록
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
