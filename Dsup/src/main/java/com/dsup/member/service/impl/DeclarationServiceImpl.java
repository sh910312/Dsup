package com.dsup.member.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.member.DeclarationVO;
import com.dsup.member.service.DeclarationService;

@Service
public class DeclarationServiceImpl implements DeclarationService {

	@Autowired
	DeclarationDAO DeclarationDAO;
	
	@Override
	public List<DeclarationVO> DeclarationVOList(DeclarationVO vo) {
		return DeclarationDAO.DeclarationList(vo);
	}
	
}
