package com.dsup.admin.user;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.UserVO;
import com.dsup.pay.PayHisIfTbVO;

@Repository
public class AdminUserDAOMybatis {
	@Resource(name="sqlSessionTemplate") SqlSessionTemplate mybatis;
	
	public List<PayHisIfTbVO> getPayHistory() {
		return mybatis.selectList("AdminUserDAO.getPayHistory");
	}
	
	public List<UserVO> userSchema() {
		return mybatis.selectList("AdminUserDAO.userSchema");
	}
}
