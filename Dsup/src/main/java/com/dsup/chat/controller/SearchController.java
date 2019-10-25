package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dsup.chat.SearchVO;
import com.dsup.chat.service.SearchService;

@Controller
public class SearchController {

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)

	@Autowired
	SearchService searchservice;

	// 등록
	@RequestMapping("/insertSearchForm")
	public String insertSearchForm() {

		return "chat/keyword/insertform";
	}

	// 등록처리
	@RequestMapping("/insertSearch")
	public String insertSearch(SearchVO vo, HttpServletRequest request, HttpSession session) {
		
		vo.setUser_id("1"); // 로그인 세션 살려놓기 ( 1 = 관리자)
		searchservice.insertSearch(vo); // 등록 실행 끝나면 아래 실행
		// redirect: << 다시 요청하는거(재요청)
		return "redirect:/insert"; // 이쪽으로 이동
	}

	// 상세조회
	@RequestMapping("/getSearch")
	public String get(SearchVO vo, Model model) {
		model.addAttribute("search", searchservice.get(vo));

		return "chat/keyword/get"; // board폴더 및에 getBoard.jsp로 가라!
	}

	// 전체조회
	@RequestMapping("/getlistSearch")
	public String getMap(SearchVO vo, Model model) {
		model.addAttribute("list", searchservice.getMap(vo));
		return "chat/keyword/search";
	}

}