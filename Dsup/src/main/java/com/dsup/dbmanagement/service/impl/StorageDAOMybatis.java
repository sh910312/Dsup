package com.dsup.dbmanagement.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;

@Repository
public class StorageDAOMybatis {
	
	@Resource(name="sqlSessionTemplate") SqlSessionTemplate mybatis;
	
	// 1022 테이블스페이스 이름 조회
	public List<TablespaceVO> getStorageList(String userId) {
		List<TablespaceVO> list = mybatis.selectList("StorageDAO.getTablespaceList", userId);
		return list;
	}
	
	// 테이블 스페이스 삭제
	public void deleteStorage(String tablespaceName) {
		mybatis.delete("StorageDAO.deleteTablespace", tablespaceName);
	}
	
	// [윤정1030] 테이블스페이스 생성
	public void createStorage(String sql) {
		mybatis.insert("StorageDAO.createTablespace", sql);
	}
	// [윤정1030] 테이블스페이스 생성 후, user_tbspc_tb에 데이터 삽입
	public void insertUserTbspcTb(UserTbspcTbVO userTbspcTb) {
		mybatis.insert("StorageDAO.insertUserTbspcTb", userTbspcTb);
	}
	
	// [윤정1030] 테이블스페이스 상세 조회 (사용량 등등)
	public List<TablespaceVO> getStorage(UserTbspcTbVO userTbspcTb) {
		return mybatis.selectList("StorageDAO.getStorage", userTbspcTb);
	}
	
	// [윤정1031] 테이블스페이스 단건 조회
	public TablespaceVO getStorageOne(UserTbspcTbVO userTbspcTb) {
		return mybatis.selectOne("StorageDAO.getStorage", userTbspcTb);
	}
	
	// [윤정1031] 데이터파일 조회
	public List<DatafileVO> getDatafile(String tablespaceName) {
		return mybatis.selectList("StorageDAO.getDatafile", tablespaceName);
	}
	
	// [윤정1031] 테이블스페이스명 중복,예약어 체크
	public String tsNameChk(String tablespaceName) {
		return mybatis.selectOne("StorageDAO.tsNameChk", tablespaceName);
	}
	
	// [윤정1107] user_tbspc_tb에 volumn 입력
	public void recordVolumn (String tablespaceName) {
		mybatis.insert("StorageDAO.recordVolumn", tablespaceName);
	}
	
	// [윤정 1108] 종량제 이용량(전체 테이블스페이스 용량) 조회
	public UserTbspcTbVO getVolumn(UserTbspcTbVO vo) {
		return mybatis.selectOne("StorageDAO.getVolumn", vo);
	}
}
