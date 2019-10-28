package com.dsup.dbmanagement.service.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.dbmanagement.TablespaceVO;

@Repository
public class StorageDAOMybatis {
	
	@Autowired SqlSessionTemplate mybatis;
	
	// 1022 테이블스페이스 리스트 조회
	public List<TablespaceVO> getStorageList(String tablespaceName) {
		List<TablespaceVO> list = mybatis.selectList("StorageDAO.getTablespaceList", tablespaceName);
		return list;
	}
	
	// 테이블 스페이스 삭제
	public void deleteStorage(String tablespaceName) {
		mybatis.delete("StorageDAO.deleteTablespace", tablespaceName);
	}
}
