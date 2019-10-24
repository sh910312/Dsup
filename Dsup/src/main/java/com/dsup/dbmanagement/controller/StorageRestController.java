package com.dsup.dbmanagement.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.service.StorageService;

@RestController
public class StorageRestController {
	@Autowired
	StorageService storageService;
	
	// 테이블스페이스 전체 리스트 조회 (get)
	@RequestMapping(value="/tablespaceList", method=RequestMethod.GET)
	public List<TablespaceVO> storageList(String keyword) {
		return storageService.getStorageList(keyword);
	}
	
	// 데이터파일 리스트 조회(get)
	@RequestMapping(value="/datafileList/{tablespaceName}", method=RequestMethod.GET)
	public List<DatafileVO> datafileList(@PathVariable String tablespaceName) {
		return storageService.getDatafileList(tablespaceName);
	}
}
