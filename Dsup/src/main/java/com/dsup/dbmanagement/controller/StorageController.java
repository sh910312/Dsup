package com.dsup.dbmanagement.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.pay.ServiceStateTbVO;

@Controller
public class StorageController {
	@Autowired StorageService storageService;
	
	// [윤정1022] 테이블스페이스 리스트 페이지로 이동
	@RequestMapping("/storageList")
	public String StorageList(String keyword, Model model) {
		return "dbmanagement/storage/storageList";
	}
	
	// [윤정1030] 테이블스페이스 목록 + 사용량
	@ResponseBody
	@RequestMapping(value="/getStorage",  method=RequestMethod.GET)
	public List<TablespaceVO> getStorage(HttpSession session) {
		UserTbspcTbVO vo = new UserTbspcTbVO();
		vo.setUserId((String)session.getAttribute("userId"));
		vo.setTablespaceName(""); // ☆☆☆☆테이블스페이스 이름으로 검색 만들어야 함!!!
		return storageService.getStorage(vo);
	}
	
	// 삭제
	@RequestMapping("/storageDelete")
	public String StorageDelete(String tablespaceName) {
		storageService.deleteStorage(tablespaceName);
		return "redirect:storageList";
	}
	
	// user_tbspc_tb 조회 - (테이블스페이스 이름, volumn만 있음)
	@ResponseBody
	@RequestMapping(value="/tablespaceList", method=RequestMethod.GET)
	public List<TablespaceVO> getTablespaceList(HttpSession session){
		String userId = (String)session.getAttribute("userId");
		return storageService.getStorageList(userId);
	}
	
	// [윤정 1029] 테이블스페이스 생성 페이지로 이동
	@RequestMapping("/storageCreateForm")
	public ModelAndView storageCreateForm() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dbmanagement/storage/storageCreateForm");
		return mv;
	}
	
	// [윤정 1029] 테이블스페이스 생성
	@RequestMapping("/storageCreate")
	public String storageCreate(@RequestParam String sql, @RequestParam String tablespaceName, HttpSession session) {
		UserTbspcTbVO vo = new UserTbspcTbVO();
		tablespaceName = tablespaceName.toUpperCase();
		vo.setTablespaceName(tablespaceName);
		vo.setUserId((String)session.getAttribute("userId"));
		storageService.createStorage(sql, vo);
		return "redirect:storageList";
	}
	
	// [윤정 1031] 데이터파일 상세보기
	@RequestMapping("/storageShow")
	public ModelAndView storageShow(@RequestParam String tablespaceName, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		String userId = (String)session.getAttribute("userId");
		UserTbspcTbVO vo = new UserTbspcTbVO();
		vo.setUserId(userId);
		vo.setTablespaceName(tablespaceName);
		TablespaceVO ts = new TablespaceVO();
		ts = storageService.getStorageOne(vo);
		
		if(ts != null) {
			mv.addObject("ts", ts);
			
			List<DatafileVO> list = new ArrayList<DatafileVO>();
			list = storageService.getDatafile(ts.getTablespaceName());
			for(DatafileVO df : list) {
				String[] arr = df.getFileName().split("\\\\");
				df.setFileName(arr[arr.length-1]);
			}
			mv.addObject("df", list);
		}
		mv.setViewName("dbmanagement/storage/storageShow");
		return mv;
	}
	
	// [윤정 1031] 테이블스페이스명 중복확인, 예약어 체크
	@RequestMapping(value="/tsNameChk", method=RequestMethod.GET)
	@ResponseBody
	public int tsNameChk(@RequestParam String tablespaceName) {
		return storageService.tsNameChk(tablespaceName);
	}
	
	// [윤정 1101] 테이블스페이스 수정 폼으로 이동
	@RequestMapping("/storageUpdateForm")
	public ModelAndView storageUpdateForm(@RequestParam String tablespaceName, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		String userId = (String)session.getAttribute("userId");
		UserTbspcTbVO vo = new UserTbspcTbVO();
		vo.setUserId(userId);
		vo.setTablespaceName(tablespaceName);
		TablespaceVO ts = new TablespaceVO();
		ts = storageService.getStorageOne(vo);
		
		if(ts != null) {
			mv.addObject("ts", ts);
			List<DatafileVO> list = new ArrayList<DatafileVO>();
			list = storageService.getDatafile(ts.getTablespaceName());
			for(DatafileVO df : list) {
				String[] arr = df.getFileName().split("\\\\");
				df.setFileName(arr[arr.length-1]);
			}
			mv.addObject("df", list);
//			mv.addObject("df", storageService.getDatafile(ts.getTablespaceName()));
		}
		mv.setViewName("dbmanagement/storage/storageUpdateForm");
		return mv;
	}
	
	// [윤정 1104] 테이블스페이스 수정 완료
	@RequestMapping("/sotrageUpdate")
	public String storageUpdate(@RequestParam String sql, @RequestParam String newName) {
		storageService.storageUpdate(sql, newName);
		return "redirect:storageList";
	}
	
	// [윤정 1107] 이용중인 종량제 조회
	@RequestMapping(value = "/serviceState", method=RequestMethod.GET)
	@ResponseBody
	public ServiceStateTbVO serviceState(HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		return storageService.serviceState(userId);
	}
	
	// [윤정1107] 이용중인 용량
	@RequestMapping(value = "/volumn", method = RequestMethod.GET)
	@ResponseBody
	public float getVolumn(@RequestBody UserTbspcTbVO vo) {
		System.out.println(vo);
		return 0;
	}
}