package com.dsup.member.service;

import java.util.List;
import java.util.Map;

import com.dsup.member.MemberVO;

public interface MemberService {
	public MemberVO getMember(MemberVO vo);
	public List<MemberVO> getMemberList(MemberVO vo);
	public List<Map> getMemberListMap(MemberVO user);
	//등록
	public Map insertMember(MemberVO vo);
	//수정
	public int updateMember(MemberVO vo);
	//삭제
	public int deleteMember(MemberVO vo);
	//로그인 체크
	public MemberVO login(MemberVO vo);
	// 탈퇴(윤정)
	public int withdrawal(MemberVO vo);
}
