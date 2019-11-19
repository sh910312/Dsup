package com.dsup.chat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.chat.RpVO;
import com.dsup.chat.service.RpService;

@Service
public class RpServiceImpl implements RpService {

	@Autowired
	RpDAOMybatis rpDAOMybatis;

	@Override // 신고하기
	public void inRp(RpVO vo) {
		rpDAOMybatis.inRp(vo);
	}

	@Override // 신고 리스트
	public List<RpVO> RpList(RpVO vo) {
		return rpDAOMybatis.RpList();
	}

	@Override // 상세보기
	public RpVO getRp(RpVO vo) {
		// TODO Auto-generated method stub
		return rpDAOMybatis.getRp(vo);
	}

	@Override // 중복체크
	public int checkRp(RpVO vo) {
		// TODO Auto-generated method stub
		return rpDAOMybatis.checkRp(vo);
	}
	

}
