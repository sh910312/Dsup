package com.dsup.pay.service.impl;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.pay.PayVO;

@Repository
public class PayDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mybatis;
	//등록
	public int insertPay(PayVO dto) {
		System.out.println("mybatis 결제 등록");
		return mybatis.insert("PayDAO.insertPay", dto);
	} 
	
	public PayVO getCancelYn(PayVO pay) {
		return mybatis.selectOne("PayDAO.getCancelYn", pay);
	}
	
	public PayVO getPay(PayVO pay) {
		return mybatis.selectOne("PayDAO.getPay", pay);
	}
}
