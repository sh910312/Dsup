package com.dsup.dbmanagement.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.service.StorageService;

@Service
public class StorageServiceImpl implements StorageService {
	
	@Autowired StorageDAOMybatis dao;

	@Override
	public List<TablespaceVO> getStorageList(String tablespaceName) {
		return dao.getStorageList(tablespaceName);
	}

	@Override
	public void deleteStorage(String tablespaceName) {
		dao.deleteStorage(tablespaceName);
	}

	// [윤정 1030] 테이블스페이스 생성
	@Override
	public void createStorage(String sql, UserTbspcTbVO vo) {
		dao.createStorage(sql);
		dao.insertUserTbspcTb(vo);
	}

}
