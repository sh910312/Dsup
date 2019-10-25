package com.dsup.distributing.service.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.distributing.SchemaVO;

@Repository
public class SchemaDAOMybatis {

	@Autowired SqlSessionTemplate mybatis;
	
	public SchemaVO selectSchema(SchemaVO vo) {
		return mybatis.selectOne("SchemaDAO.selectShema", vo);
	}
}
