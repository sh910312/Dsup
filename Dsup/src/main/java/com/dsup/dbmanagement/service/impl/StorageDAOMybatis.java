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
	
	// 1022 테이블스페이스 리스트 조회
	public List<TablespaceVO> getStorageList(String tablespaceName) {
		List<TablespaceVO> list = mybatis.selectList("StorageDAO.getTablespaceList", tablespaceName);
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
}
