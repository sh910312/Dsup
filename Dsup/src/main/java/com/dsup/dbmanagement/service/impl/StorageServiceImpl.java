package com.dsup.dbmanagement.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.service.StorageService;

/*
 * 윤정
 * 
 */
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

}
