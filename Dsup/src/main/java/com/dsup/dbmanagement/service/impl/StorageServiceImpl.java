package com.dsup.dbmanagement.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.service.StorageService;

@Service
public class StorageServiceImpl implements StorageService {
	
	@Autowired StorageDAOMybatis dao;

	@Override
	public List<TablespaceVO> getStorageList(String userId) {
		return dao.getStorageList(userId);
	}

	@Override
	public void deleteStorage(String tablespaceName) {
		dao.deleteStorage(tablespaceName);
	}

	// [윤정 1030] 테이블스페이스 생성
	@Override
	public void createStorage(String sql, UserTbspcTbVO vo) {
		File directory = new File("D:\\dsup\\datafiles");
		if(!directory.exists()) directory.mkdirs();
		dao.createStorage(sql);
		dao.insertUserTbspcTb(vo);
	}

	// [윤정 1030] 테이블스페이스 리스트 상세 조회
	@Override
	public List<TablespaceVO> getStorage(UserTbspcTbVO vo) {
		return dao.getStorage(vo);
	}
	
	// [윤정 1031] 테이블스페이스 리스트 단건 조회
		@Override
		public TablespaceVO getStorageOne(UserTbspcTbVO vo) {
			return dao.getStorageOne(vo);
		}

	// [윤정 1031] 데이터파일 리스트 조회
	@Override
	public List<DatafileVO> getDatafile(String tablespaceName) {
		return dao.getDatafile(tablespaceName);
	}

	// [윤정 1031] 테이블스페이스명 중복, 예약어 체크 -> 중복이면 0, 아니면 1
	@Override
	public int tsNameChk(String tablespaceName) {
		if(dao.tsNameChk(tablespaceName) == null)
			return 1;
		else
			return 0;
	}

}
