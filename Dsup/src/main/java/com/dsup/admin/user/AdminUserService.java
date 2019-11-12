package com.dsup.admin.user;

import java.util.List;

import com.dsup.dbmanagement.UserVO;
import com.dsup.pay.PayHisIfTbVO;

public interface AdminUserService {
	public List<PayHisIfTbVO> getPayHistory();
	List<UserVO> userSchema();
}
