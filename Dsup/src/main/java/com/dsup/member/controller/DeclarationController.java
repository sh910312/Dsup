package com.dsup.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.member.service.DeclarationService;

@Controller
public class DeclarationController {
	@Autowired DeclarationService declarationService;
	
	//@RequestMapping
}
