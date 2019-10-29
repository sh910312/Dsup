package com.dsup.member.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dsup.member.MemberVO;
import com.dsup.member.service.MemberService;

@RestController
public class MemberRestController {
	
	@Autowired MemberService memberService;
	
	//목록
	@RequestMapping(value="/members", method=RequestMethod.GET)
	public List<MemberVO> getUser(MemberVO vo, Model model) {
		//model.addAttribute("user", userService.getUser(vo));
		return memberService.getMemberList(vo);
	}
	
	//등록
	@RequestMapping(value="/members"
				,method = RequestMethod.POST		
				,consumes="application/json"	)	//넘겨받는모든값이 제이슨	//제이슨들어가면 반드시@RequestBody써줘야함
	public Map insertMember(@RequestBody MemberVO vo, Model model) {
		memberService.insertMember(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("member", true);
		return map;
	}
	
	//조회
	@RequestMapping(value="/members/{userId}", method=RequestMethod.GET)
	public MemberVO getUser(@PathVariable String userId, MemberVO vo, Model model ) {
		vo.setUserId(userId);
		return memberService.getMember(vo);
	}
	
	//삭제
	@RequestMapping(value="/members/{userId}", method=RequestMethod.DELETE)
	public Map deleteUser(@PathVariable String userId, MemberVO vo, Model model) {
		vo.setUserId(userId);
		memberService.deleteMember(vo);
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("result", Boolean.TRUE);
		
		return Collections.singletonMap("result", true);
	}
	
	//수정
	@RequestMapping(value="/members", method=RequestMethod.PUT
					,consumes="application/json")	//consumes 파라미터 받을거있을때
	public MemberVO updateUser(@RequestBody MemberVO vo, Model model) {
		memberService.updateMember(vo);
		return vo;
	}
	
}
