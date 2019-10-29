package com.dsup.dbmanagement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.service.StorageService;

@Controller
public class StorageController {
	@Autowired StorageService storageService;

	
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
	
	// 테이블스페이스 리스트 조회
	@ResponseBody
	@RequestMapping(value="/tablespaceList", method=RequestMethod.GET)
	public List<TablespaceVO> getTablespaceList(){
		return storageService.getStorageList("");
	}
	
	// [윤정 1029] 테이블스페이스 생성 페이지로 이동
	@RequestMapping("/storageCreateForm")
	public String storageCreateForm() {
		return "dbmanagement/storage/storageCreateForm";
	}
	
	// [윤정 1029] 테이블스페이스 생성
	@RequestMapping("/storageCreate")
	public String storageCreate() {
		
		return "redirect:storageList";
	}
}