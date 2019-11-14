package com.dsup.member.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.member.MemberVO;
import com.dsup.member.service.MemberService;


@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO memberDAO;
	@Override
	public MemberVO getMember(MemberVO vo) {
		return memberDAO.getMember(vo);
	}
	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return memberDAO.getMemberList(vo);
	}
	@Override
	public List<Map> getMemberListMap(MemberVO vo) {
		return memberDAO.getMemberListMap(vo);
	}
	public Map insertMember(MemberVO dto) {	
		Map<String, Object> map = new HashMap<String, Object>();
		//중복체크
		MemberVO result = memberDAO.getMember(dto);
		if(result != null) {
			map.put("idcheck", true);
			map.put("result", false);
		} else if(! dto.getPassword().equals(dto.getPassword2())) {
			map.put("passwordcheck", true);
			map.put("result", false);
		} else {
			map.put("result", true);
			memberDAO.insertMember(dto);
		}
		return map;
	}
	public int updateMember(MemberVO dto) {
		return memberDAO.updateMember(dto);
	}
	public int deleteMember(MemberVO dto) {
		return memberDAO.deleteMember(dto);
	}
	
	@Override
	public MemberVO login(MemberVO vo) {
		//id로 조회 하고
		MemberVO member = memberDAO.getMember(vo);
		if(member != null) {
			if(member.getPassword().equals(vo.getPassword())) {
				return member;
			}
		}
		return null;
	}

}
