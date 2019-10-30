package com.dsup.dbmanagement.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class dbmanagementController {
	@Value("#{config['backup.path']}") String backupPath;
	
	// [윤정1022] DB관리의 메인 페이지로 이동
	@RequestMapping("/dbIndex")
	public String DbIndex() {
		System.out.println(backupPath);
		return "dbmanagement/dbIndex";
	}
}
