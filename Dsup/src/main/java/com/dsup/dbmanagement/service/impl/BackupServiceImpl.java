package com.dsup.dbmanagement.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.dsup.dbmanagement.service.BackupService;

public class BackupServiceImpl implements BackupService {

	@Autowired BackupDAOMybatis dao;
	
	@Override
	public void BackupCreate(String tablespaceName) {
		dao.beginBackup(tablespaceName);
	}

}
