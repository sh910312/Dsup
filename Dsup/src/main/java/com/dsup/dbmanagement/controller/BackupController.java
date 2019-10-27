package com.dsup.dbmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dsup.dbmanagement.service.BackupService;

@Controller
public class BackupController {

	@Autowired BackupService backupService;
	
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
	
	// [윤정1027] 백업하기
	@RequestMapping("/backupCreate")
	public String backupCreate(@RequestParam String tablespaceName) {
		System.out.println("백업 컨트롤러 실행");
		System.out.println(tablespaceName);
		//storageService.beginBackup("TEST1027");
		return "dbmanagement/backup/backupCreateForm";
	}
}
