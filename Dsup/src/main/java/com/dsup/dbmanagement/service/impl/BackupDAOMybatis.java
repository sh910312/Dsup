package com.dsup.dbmanagement.service.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BackupDAOMybatis {
	@Autowired SqlSessionTemplate mybatis;

	// [윤정1027] 테이블스페이스 백업 시작
 	public void beginBackup(String tablespaceName) {
		mybatis.insert("BackupDAO.beginBackup", tablespaceName);
	}
 	
 	// [윤정1027] 테이블스페이스 백업 종료
 	public void endBackup(String tablespaceName) {
 		mybatis.insert("BackupDAO.endBackup", tablespaceName);
 	}
}
