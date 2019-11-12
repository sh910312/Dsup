package com.dsup.admin.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.dbmanagement.service.UserService;
import com.dsup.pay.PayHisIfTbVO;

@Controller
public class AdminUserController {
	@Autowired AdminUserService adminUser;
	@Autowired StorageService storageService;
	@Autowired UserService userService;
	
	// [윤정 1111] 결제내역
	@ResponseBody
	@RequestMapping(value="/payHistory", method=RequestMethod.GET)
	public List<PayHisIfTbVO> getPayHistory() {
		return adminUser.getPayHistory();
	}
	
	// [윤정1111] 테이블스페이스 목록 + 사용량
	@ResponseBody
	@RequestMapping(value="/getAdminStorage",  method=RequestMethod.GET)
	public List<TablespaceVO> getAdminStorage(HttpSession session) {
		UserTbspcTbVO vo = new UserTbspcTbVO();
		vo.setUserId("---관리자---");
		return storageService.getStorage(vo);
	}
	
	// [윤정1111] 유저
	//목록조회
		@RequestMapping(value="/userSchema", method=RequestMethod.GET)
		@ResponseBody
		public List<UserVO> userSchema() {
			return adminUser.userSchema();
		}
}
