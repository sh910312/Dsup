package com.dsup.distributing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.distributing.SchemaVO;
import com.dsup.distributing.service.SchemaService;

@Controller
public class SchemaController {

	@Autowired SchemaService schemaService;
	
	@RequestMapping("/serviceSchemaList")
	public String serviceSchemaList(SchemaVO vo, Model model) {
		model.addAttribute("schemaUse", schemaService.serviceSchemaList(vo));
		return "distributing/distributingMainTest";
	}
}
