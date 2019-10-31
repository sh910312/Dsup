package com.dsup.dbmanagement.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.service.StorageService;

@Controller
public class StorageController {
	@Autowired StorageService storageService;

	
	// [윤정1022] 테이블스페이스 리스트 페이지로 이동
	@RequestMapping("/storageList")
	public String StorageList(String keyword, Model model) {
		return "dbmanagement/storage/storageList";
	}
	
	// [윤정1030] 테이블스페이스 목록
	@ResponseBody
	@RequestMapping(value="/getStorage",  method=RequestMethod.GET)
	public List<TablespaceVO> getStorage(HttpSession session) {
		UserTbspcTbVO vo = new UserTbspcTbVO();
		vo.setUserId((String)session.getAttribute("userId"));
		vo.setTablespaceName(""); // ☆☆☆☆테이블스페이스 이름으로 검색 만들어야 함!!!
		return storageService.getStorage(vo);
	}
	
	// 삭제
	@RequestMapping("/storageDelete")
	public String StorageDelete(String tablespaceName) {
		storageService.deleteStorage(tablespaceName);
		return "redirect:storageList";
	}
	
	// 테이블스페이스 리스트 (이름만) 조회 - 백업생성폼에서 쓸 것
	@ResponseBody
	@RequestMapping(value="/tablespaceList", method=RequestMethod.GET)
	public List<TablespaceVO> getTablespaceList(HttpSession session){
		String userId = (String)session.getAttribute("userId");
		return storageService.getStorageList(userId);
	}
	
	// [윤정 1029] 테이블스페이스 생성 페이지로 이동
	@RequestMapping("/storageCreateForm")
	public String storageCreateForm() {
		return "dbmanagement/storage/storageCreateForm";
	}
	
	// [윤정 1029] 테이블스페이스 생성
	@RequestMapping("/storageCreate")
	public String storageCreate(@RequestParam String sql, @RequestParam String tablespaceName, HttpSession session) {
		UserTbspcTbVO vo = new UserTbspcTbVO();
		tablespaceName = tablespaceName.toUpperCase();
		vo.setTablespaceName(tablespaceName);
		vo.setUserId((String)session.getAttribute("userId"));
		storageService.createStorage(sql, vo);
		return "redirect:storageList";
	}
}