package com.dsup.pay.service.impl;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.member.MemberVO;
import com.dsup.pay.PayHisIfTbVO;


@Repository
public class PayDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mybatis;
	//등록
	public int insertPay(PayHisIfTbVO dto) {
		System.out.println("mybatis 결제 등록");
		return mybatis.insert("PayDAO.insertPay", dto);
	} 
	
	public PayHisIfTbVO getPay(PayHisIfTbVO pay) {
		return mybatis.selectOne("PayDAO.getPay", pay);
	}
	
	public int updatePay(PayHisIfTbVO vo) {
		return mybatis.update("PayDAO.updatePay", vo);
	}
}
