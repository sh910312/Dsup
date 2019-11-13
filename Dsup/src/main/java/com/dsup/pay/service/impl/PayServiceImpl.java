package com.dsup.pay.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.member.MemberVO;
import com.dsup.pay.PayHisIfTbVO;
import com.dsup.pay.service.PayService;

@Service
public class PayServiceImpl implements PayService {

	@Autowired
	PayDAO payDAO;
	
	public int insertPay(PayHisIfTbVO dto) {
		payDAO.updatePay(dto);
		return payDAO.insertPay(dto);
	}

	@Override
	public PayHisIfTbVO getPay(PayHisIfTbVO vo) {
		return payDAO.getPay(vo);
	}

	
}
