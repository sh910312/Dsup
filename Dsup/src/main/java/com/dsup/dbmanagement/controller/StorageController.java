package com.dsup.dbmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.dbmanagement.service.StorageService;

@Controller
public class StorageController {
	
	@Autowired StorageService storageService;

	// [윤정1022] DB관리의 메인 페이지로 이동
	@RequestMapping("/dbIndex")
	public String DbIndex() {
		return "dbmanagement/dbIndex";
	}
	
	// [윤정1022] 테이블스페이스 리스트 페이지로 이동
	@RequestMapping("/storageList")
	public String StorageList(String keyword, Model model) {
		model.addAttribute("list", storageService.getStorageList(keyword));
		return "dbmanagement/storage/storageList";
	}
	
	// 삭제
	@RequestMapping("/storageDelete")
	public String StorageDelete(String tablespaceName) {
		storageService.deleteStorage(tablespaceName);
		return "redirect:storageList";
	}
}
