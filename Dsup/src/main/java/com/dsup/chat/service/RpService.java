package com.dsup.chat.service;

import java.util.List;

import com.dsup.chat.RpVO;

public interface RpService {

	// 등록
	void inRp(RpVO vo);

	// 전체조회
	List<RpVO> RpList(RpVO vo);


}
