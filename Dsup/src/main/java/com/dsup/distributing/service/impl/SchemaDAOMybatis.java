package com.dsup.distributing.service.impl;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.distributing.SchemaVO;

@Repository
public class SchemaDAOMybatis {

	@Resource(name="sqlSessionTemplate") SqlSessionTemplate mybatis;
	
	public SchemaVO selectSchema(SchemaVO vo) {
		return mybatis.selectOne("SchemaDAO.selectShema", vo);
	}
}
