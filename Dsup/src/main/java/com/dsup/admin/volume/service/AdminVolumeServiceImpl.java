package com.dsup.admin.volume.service;

import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminVolumeServiceImpl implements AdminVolumeService{
	@Autowired AdminVolumeDAO dao;
	
	@Override
	public LinkedHashMap<String, Object> getTableSpaceCondition() {
		// TODO Auto-generated method stub
		LinkedHashMap<String, Object> result = dao.getTableSpaceCondition();
		
		return result;
	}

}
