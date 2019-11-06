package com.dsup.pay.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.pay.PayVO;
import com.dsup.pay.service.PayService;

@Service
public class PayServiceImpl implements PayService {

	@Autowired
	PayDAO PayDAO;
	
	public int insertPay(PayVO dto) {
		return PayDAO.insertPay(dto);
	}

	@Override
	public PayVO getPay(PayVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
}
