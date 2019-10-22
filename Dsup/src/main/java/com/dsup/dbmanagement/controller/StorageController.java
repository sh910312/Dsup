package com.dsup.dbmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StorageController {

	// [윤정1022] DB관리의 메인 페이지로 이동
	@RequestMapping("/dbIndex")
	public String DbIndex() {
		return "dbmanagement/dbIndex";
	}
	
	// [윤정1022] 테이블스페이스 리스트 페이지로 이동
	@RequestMapping("/storageList")
	public String StorageList() {
		return "dbmanagement/storage/storageList";
	}
}
