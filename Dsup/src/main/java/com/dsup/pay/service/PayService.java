package com.dsup.pay.service;

import com.dsup.pay.PayVO;

public interface PayService {
	public PayVO getPay(PayVO vo);
	
	public int insertPay(PayVO vo);
	
}
