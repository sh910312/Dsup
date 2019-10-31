package com.dsup.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dsup.chat.Paging;
import com.dsup.chat.ReVO;
import com.dsup.chat.SearchVO;
import com.dsup.chat.service.ReService;
import com.dsup.chat.service.SearchService;

@Controller
public class SearchController {


	@Autowired
	SearchService searchservice;
	
	@Autowired
	ReService reService;
	
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
	public String getSearch(HttpServletRequest request, Model model, SearchVO svo, ReVO revo, Paging repaging) {
		
		model.addAttribute("search", searchservice.getSearch(svo));
		model.addAttribute("reList", reService.ReMap(revo, repaging)); // 댓글 리스트 불러오기
		model.addAttribute("repaging",repaging);
		
		return "chat/keyword/getsearch";
	}
	
//	// 상세조회
//	@RequestMapping("/getSearch")
//	public String getSearch(HttpServletRequest request, Model model, SearchVO svo, ReVO revo) {
//		
//		model.addAttribute("search", searchservice.getSearch(svo));
//		
//		model.addAttribute("reList", reService.ReMap(revo)); // 댓글 리스트 불러오기
//		return "chat/keyword/getsearch";
//	}


//	// 전체 조회
//	@RequestMapping("/SearchMap")
//	public String SearchMap(SearchVO vo, Model model) {
//
//		model.addAttribute("searchList", searchservice.SearchMap(vo));
//		return "chat/keyword/search";
//	}
	
	
	// 전체 조회
	@RequestMapping("/SearchMap")
	public ModelAndView SearchMap(ModelAndView mv,  SearchVO vo, Paging paging) {
		
		mv.addObject("searchList", searchservice.SearchMap(vo,paging));
		mv.addObject("paging", paging);
		mv.setViewName("chat/keyword/search");
		return mv;

	}

}