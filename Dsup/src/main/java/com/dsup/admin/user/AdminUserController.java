package com.dsup.admin.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.pay.PayHisIfTbVO;

@Controller
public class AdminUserController {
	@Autowired AdminUserService adminUser;
	
	@ResponseBody
	@RequestMapping(value="/payHistory", method=RequestMethod.GET)
	public List<PayHisIfTbVO> getPayHistory() {
		return adminUser.getPayHistory();
	}
}
