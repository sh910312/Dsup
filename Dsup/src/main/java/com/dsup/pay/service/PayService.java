package com.dsup.pay.service;

import com.dsup.pay.PayHisIfTbVO;

public interface PayService {
	public PayHisIfTbVO getPay(PayHisIfTbVO vo);
	
	public int insertPay(PayHisIfTbVO vo);
	
	
}
