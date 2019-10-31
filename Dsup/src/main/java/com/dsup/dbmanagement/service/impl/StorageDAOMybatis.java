package com.dsup.dbmanagement.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}
