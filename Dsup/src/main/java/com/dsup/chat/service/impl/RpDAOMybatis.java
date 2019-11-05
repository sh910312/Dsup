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

}
