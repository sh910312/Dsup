package com.dsup.dbmanagement.service;

import java.util.List;

import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;

public interface StorageService {
	List<TablespaceVO> getStorageList(String tablespaceName);
	void deleteStorage(String tablespaceName);
	void createStorage(String sql, UserTbspcTbVO vo);
}
