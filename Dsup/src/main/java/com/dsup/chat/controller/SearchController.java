package com.dsup.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.SearchVO;
import com.dsup.chat.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	SearchService searchservice;

	// 등록폼
	@RequestMapping("/insert")
	public String insertBoardForm() {
		return "keyword/insert";
	}

	// 단건조회
	@RequestMapping("/get")
	public String getBoard(SearchVO vo, Model model) {
		model.addAttribute("search", searchservice.get(vo));

		return "keyword/get"; // board폴더 및에 getBoard.jsp로 가라!
	}

	// 전체조회
	@RequestMapping("/getdMap")
	public String getMap(SearchVO vo, Model model) {
		model.addAttribute("list", searchservice.getMap(vo));
		return "keyword/getList";
	}

}