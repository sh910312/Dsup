package com.dsup.dbmanagement.service.impl;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.service.MessgeService;
import com.dsup.dbmanagement.service.MessgeVO;

@Service
public class MessgeServiceImpl implements MessgeService {
	
	@Autowired
	MessgeDAO MessgeDAO;

	@Override
	public List<MessgeVO> messgeList(MessgeVO vo) {
		return MessgeDAO.messgeList(vo);
	}

	
}
