package com.dsup.dbmanagement.service;

import java.util.List;

import com.dsup.dbmanagement.TablespaceVO;

public interface StorageService {
	List<TablespaceVO> getStorageList(String keyword);
	void deleteStorage(String tablespaceName);
}
