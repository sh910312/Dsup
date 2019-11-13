package com.dsup.admin.volume.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminVolumeServiceImpl implements AdminVolumeService{
	@Autowired AdminVolumeDAO dao;
	
	@Override
	public ArrayList<Object> getTableSpaceCondition() {
		// TODO Auto-generated method stub
		ArrayList<Object> result = dao.getTableSpaceCondition();
		
		return result;
	}

	@Override
	public ArrayList<Object> getUserVolumCondition() {
		// TODO Auto-generated method stub
		ArrayList<Object> result = dao.getUserVolumCondition();
		
		return result;
	}

	@Override
	public ArrayList<Object> getDataFileVolumeCondition() {
		// TODO Auto-generated method stub
		ArrayList<Object> result = dao.getDataFileVolumeCondition();
		
		return result;
	}

}
