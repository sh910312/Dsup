package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.chat.SearchVO;
import com.dsup.chat.service.SearchService;

@Controller
public class SearchController {

	// 등록(inset) / 상세조회(get) / 전체조회(getList) / 검색(getMap)

	@Autowired
	SearchService searchservice;

//	// 키워드 검색창 (메인화면)
//	@RequestMapping("/search")
//	public String searchform() {
//		return "chat/keyword/search";
//	}

	// 키워드 등록
	@RequestMapping("/insertSearchForm")
	public String insertSearchForm() {

		return "chat/keyword/insertform";
	}

	// 키워드 등록처리
	@RequestMapping("/insertSearch")
	public String insertSearch(SearchVO vo, HttpServletRequest request, HttpSession session) {

		vo.setUserId("test"); // 로그인 세션 살려놓기 ( 1 = 관리자)
		System.out.println(vo);

		searchservice.insertSearch(vo); // 등록 실행 끝나면 아래 실행
		// redirect: << 다시 요청하는거(재요청)
		return "redirect:/SearchMap"; // 이쪽으로 이동 // redirech 안에는 requestmapping 내용을 넣는다
	}
	
	// 선택 삭제
	@RequestMapping("/deleteSearchList")
	public String deleteSearchList(SearchVO vo) {
		searchservice.deleteSearchList(vo);
		return "redirect:/SearchMap";
		
	}

	// 상세조회
	@RequestMapping("/getSearch")
	public String getSearch(SearchVO vo, Model model) {

		model.addAttribute("search", searchservice.getSearch(vo));
		return "chat/keyword/getsearch";
	}

	// 전체 조회
	@RequestMapping("/SearchMap")
	public String SearchMap(SearchVO vo, Model model) {

		model.addAttribute("searchList", searchservice.SearchMap(vo));
		return "chat/keyword/search";
	}

	
	
}