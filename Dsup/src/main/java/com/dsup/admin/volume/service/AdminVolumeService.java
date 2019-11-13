package com.dsup.admin.volume.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;

public interface AdminVolumeService {
	public ArrayList<Object> getTableSpaceCondition();
	public ArrayList<Object> getUserVolumCondition();
	public ArrayList<Object> getDataFileVolumeCondition();
}
