package com.dsup.member.service;

import java.util.List;

import com.dsup.member.DeclarationVO;

public interface DeclarationService {

	//신고조회리스트 
	public List<DeclarationVO> DeclarationVOList(DeclarationVO vo);
	
}
