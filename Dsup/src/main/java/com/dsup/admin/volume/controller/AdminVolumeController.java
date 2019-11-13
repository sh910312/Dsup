package com.dsup.admin.volume.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.admin.volume.service.AdminVolumeService;

@Controller
public class AdminVolumeController {
	@Autowired AdminVolumeService service;
	
	@RequestMapping("/getTableSpaceCondition")
	@ResponseBody
	public ArrayList<Object> getTableSpaceCondition(){
		ArrayList<Object> result = service.getTableSpaceCondition();
		
		return result;
	}
	
	@RequestMapping("/getUserVolumCondition")
	@ResponseBody
	public ArrayList<Object> getUserVolumCondition(){
		ArrayList<Object> result = service.getUserVolumCondition();
		
		return result;
	}
	
	@RequestMapping("/getDataFileVolumeCondition")
	@ResponseBody
	public ArrayList<Object> getDataFileVolumeCondition(){
		ArrayList<Object> result = service.getDataFileVolumeCondition();
		
		return result;
	}
}
