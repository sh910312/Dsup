package com.dsup.dbmanagement.service.impl;

import javax.annotation.Resource;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.BackupVO;
import com.dsup.dbmanagement.DatafileVO;

@Repository
public class BackupDAOMybatis {
	@Resource(name="sqlSessionTemplate") SqlSessionTemplate mybatis;

	// [윤정1027] 테이블스페이스 백업 시작
 	public void beginBackup(String tablespaceName) {
		mybatis.update("BackupDAO.beginBackup", tablespaceName);
	}
 	
 	// [윤정1027] 테이블스페이스 백업 종료
 	public void endBackup(String tablespaceName) {
 		mybatis.update("BackupDAO.endBackup", tablespaceName);
 	}
 	
 	// [윤정1028] 데이터파일 목록 가져오기
 	public List<DatafileVO> datafileList(String tablespaceName) {
 		return mybatis.selectList("BackupDAO.datafileList", tablespaceName);
 	}
 	
 	// [윤정1028] 백업테이블에 자료 입력
 	public void insertBackupList (BackupVO backup) {
 		mybatis.insert("BackupDAO.insertBackupList", backup);
 	}
 	
 	// [윤정1028] 백업파일 목록
 	public List<BackupVO> getBackupList(String userId) {
 		return mybatis.selectList("BackupDAO.getBackupList", userId);
 	}
}
