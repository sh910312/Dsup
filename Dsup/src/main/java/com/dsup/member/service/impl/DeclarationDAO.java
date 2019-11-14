package com.dsup.member.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.member.DeclarationVO;

@Repository
public class DeclarationDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mybatis;
	
	public List<DeclarationVO> DeclarationList(DeclarationVO vo) {
		return mybatis.selectOne("DeclarationDAO.DeclarationList", vo);
	}

}
