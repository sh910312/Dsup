package com.dsup.admin.volume.controller;

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
	public LinkedHashMap<String, Object> getTableSpaceCondition(){
		LinkedHashMap<String, Object> result = service.getTableSpaceCondition();
		
		return result;
	}
}
