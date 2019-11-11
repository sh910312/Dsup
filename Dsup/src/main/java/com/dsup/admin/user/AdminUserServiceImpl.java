package com.dsup.admin.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.pay.PayHisIfTbVO;

@Service
public class AdminUserServiceImpl implements AdminUserService {
	@Autowired AdminUserDAOMybatis dao;
	
	// [윤정 1111] pay_his_if_tb 조회
	@Override
	public List<PayHisIfTbVO> getPayHistory() {
		return dao.getPayHistory();
	}

}
