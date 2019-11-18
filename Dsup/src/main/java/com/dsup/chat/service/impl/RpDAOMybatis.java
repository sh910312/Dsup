package com.dsup.chat.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.chat.RpVO;

@Repository
public class RpDAOMybatis { // (p.513)

	@Resource(name = "sqlSessionTemplate")
	SqlSessionTemplate mybatis;

	// 등록
	public void inRp(RpVO vo) {
		mybatis.insert("RpDAO.inRp", vo);
	}

	// 전체 검색
	public List<RpVO> RpList() {
		return mybatis.selectList("RpDAO.RpList");
	}

	// 상세보기
	public RpVO getRp(RpVO vo) {
		return mybatis.selectOne("RpDAO.getRp", vo);
	}

	// 중복체크
	public int checkRp(RpVO vo) {
		return mybatis.selectOne("RpDAO.checkRp", vo);
	}
	
}
