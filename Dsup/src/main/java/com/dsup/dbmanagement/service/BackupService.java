package com.dsup.dbmanagement.service;

import java.util.List;

import com.dsup.dbmanagement.BackupVO;

public interface BackupService {
	public void BackupCreate(BackupVO vo, String tablespaceName);
	public List<BackupVO> getBackupList(String userId);
	public void backupDelete(BackupVO vo);
}