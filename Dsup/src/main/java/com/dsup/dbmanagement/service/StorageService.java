package com.dsup.dbmanagement.service;

import java.util.List;

import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;

public interface StorageService {
	List<UserTbspcTbVO> getStorageList(String userId);
	void deleteStorage(String tablespaceName);
	void createStorage(String sql, UserTbspcTbVO vo);
	List<TablespaceVO> getStorage(UserTbspcTbVO vo);
	TablespaceVO getStorageOne(UserTbspcTbVO vo);
	List<DatafileVO> getDatafile(String tablespaceName);
	int tsNameChk(String tablespaceName);
	void storageUpdate(String sql, String newName);
	UserTbspcTbVO getVolumn(UserTbspcTbVO vo);
}
