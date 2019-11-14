package com.dsup.member.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dsup.dbmanagement.BackupVO;
import com.dsup.dbmanagement.TablespaceVO;
import com.dsup.dbmanagement.UserTbspcTbVO;
import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.service.BackupService;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.dbmanagement.service.UserService;
import com.dsup.member.MemberVO;
import com.dsup.member.service.MemberService;

@RestController
public class MemberRestController {
	
	@Autowired MemberService memberService;
	
	//등록
	@RequestMapping(value="/members"
			,method = RequestMethod.POST		
			,consumes="application/json"	)	//넘겨받는모든값이 제이슨	//제이슨들어가면 반드시@RequestBody써줘야함
	public Map insertMember(@RequestBody MemberVO vo, Model model) {
		System.out.println(vo.getUserId());
		System.out.println(vo.getPassword());
		
		memberService.insertMember(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("member", true);
		return map;
	}
	
	//목록
	@RequestMapping(value="/members", method=RequestMethod.GET)
	public List<MemberVO> getUser(MemberVO vo, Model model) {
		//model.addAttribute("user", userService.getUser(vo));
		return memberService.getMemberList(vo);
	}
	
	
	/*
	 * //아이디중복체크
	 * 
	 * @RequestMapping(value="/members/{userId}", method=RequestMethod.POST) public
	 * int checkUserId(@RequestBody MemberVO vo, Model model) { int checkResult =
	 * memberService.getMember(vo) }
	 */
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
	public MemberVO updateUser(@RequestBody MemberVO vo, Model model, HttpSession session) {
		vo.setUserId((String)session.getAttribute("userId"));
		memberService.updateMember(vo);
		MemberVO member = memberService.getMember(vo);
		session.setAttribute("member", member);
		session.setAttribute("userId", member.getUserId());
		return vo;
	}
	
	
	// ↓윤정 회원탈퇴 신청 처리
	@Autowired StorageService storage;
	@Autowired UserService user;
	@Autowired BackupService backup;
	@RequestMapping(value = "memberWithdrawal", method = RequestMethod.PUT, consumes = "application/json")
	public Map<String, Boolean> withdrawal(@RequestBody MemberVO vo) {
		// ↓ 테이블스페이스 삭제
		List<UserTbspcTbVO> tslist = new ArrayList<UserTbspcTbVO>();
		tslist = storage.getStorageList(vo.getUserId());
		for(UserTbspcTbVO ts : tslist) 
			storage.deleteStorage(ts.getTablespaceName());
		
		// ↓ 유저 스키마 삭제
		List<UserVO> userlist = new ArrayList<UserVO>();
		userlist = user.getUserSchema(vo.getUserId());
		for(UserVO u : userlist) {
			System.out.println(u);
			user.deleteUser(u);
		}
		// ↓ 백업
		List<BackupVO> bulist = new ArrayList<BackupVO>();
		bulist = backup.getBackupList(vo.getUserId());
		int len = bulist.size();
		String buarr[] = new String[len];
		int i = 0;
		System.out.println("----------백업 삭제");
		for(BackupVO bu : bulist) {
			buarr[i] = bu.getBackupFileNm();
			System.out.println(buarr[i++]);
		}
		backup.backupDelete(buarr);
			
		// ↓ update users 
		if (memberService.withdrawal(vo) == 1)
			return Collections.singletonMap("result", true);
		else
			return Collections.singletonMap("result", false);
	}
}
