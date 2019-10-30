package com.dsup.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	@Override
	public List<Map<String, Object>> ReMap(ReVO vo) {
		// TODO Auto-generated method stub
		return reDAOMybatis.ReMap(vo);
	}

}
