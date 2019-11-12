package com.dsup.dbmanagement.service.impl;



import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.service.MessgeVO;

@Repository
public class MessgeDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mybatis;
	
	public List<MessgeVO> messgeList(MessgeVO vo){
		return mybatis.selectList("MessgeDAO.messgeList", vo);
	}

}
