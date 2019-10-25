package com.dsup.distributing.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.distributing.SchemaVO;
import com.dsup.distributing.service.SchemaService;

@Service
public class SchemaServiceImpl implements SchemaService{

	@Autowired SchemaDAOMybatis schemaDAO;
	
	@Override
	public SchemaVO selectSchema(SchemaVO vo) {
		return schemaDAO.selectSchema(vo);
	}
	
}
