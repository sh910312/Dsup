package com.dsup.dbmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BackupController {

	// [윤정1023] 백업 리스트 페이지로 이동 ----- 리스트 출력은 아직
	@RequestMapping("/backupList")
	public String BackupList() {
		return "dbmanagement/backup/backupList";
	}
	
	// [윤정1023] 백업 생성하기 페이지로 이동
	@RequestMapping("/backupCreateForm")
	public String backupCreateForm() {
		return "dbmanagement/backup/backupCreateForm";
	}
}
