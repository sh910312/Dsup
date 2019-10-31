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
	public List<TablespaceVO> getStorageList(String userId) {
		return dao.getStorageList(userId);
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

	// [윤정 1030] 테이블스페이스 리스트 상세 조회
	@Override
	public List<TablespaceVO> getStorage(UserTbspcTbVO vo) {
		return dao.getStorage(vo);
	}

}
