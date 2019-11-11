package com.dsup.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.member.MemberVO;
import com.dsup.member.service.MemberService;


@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO MemberDAO;
	@Override
	public MemberVO getMember(MemberVO vo) {
		return MemberDAO.getMember(vo);
	}
	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return MemberDAO.getMemberList(vo);
	}
	@Override
	public List<Map> getMemberListMap(MemberVO vo) {
		return MemberDAO.getMemberListMap(vo);
	}
	public int insertMember(MemberVO dto) {		
		return MemberDAO.insertMember(dto);		
	}
	public int updateMember(MemberVO dto) {
		return MemberDAO.updateMember(dto);
	}
	public int deleteMember(MemberVO dto) {
		return MemberDAO.deleteMember(dto);
	}
	
	@Override
	public MemberVO login(MemberVO vo) {
		//id로 조회 하고
		MemberVO member = MemberDAO.getMember(vo);
		if(member != null) {
			if(member.getPassword().equals(vo.getPassword())) {
				return member;
			}
		}
		return null;
	}

}
