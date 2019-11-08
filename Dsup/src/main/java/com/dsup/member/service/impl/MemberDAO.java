package com.dsup.member.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dsup.member.MemberVO;

@Repository
public class MemberDAO {
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate mybatis;

	public List<MemberVO> getMemberList(MemberVO member) {
		return mybatis.selectList("MemberDAO.getMemberList", member);
	}

	public MemberVO getMember(MemberVO member) {
		return mybatis.selectOne("MemberDAO.getMember", member);
	}

	public List<Map> getMemberListMap(MemberVO member) {
		return mybatis.selectList("MemberDAO.getMemberListMap", member);
	}
	
	public MemberVO getUserId(MemberVO member) {
		return mybatis.selectOne("MemberDAO.getUserId", member);
	}
	
	public MemberVO getPayService(MemberVO member) {
		return mybatis.selectOne("MemberDAO.getPayService", member);
	}
	// 등록
	public int insertMember(MemberVO dto) {
		System.out.println("mybatis 사용자 등록");
		return mybatis.insert("MemberDAO.insertMember", dto);
	}

	// 수정
	public int updateMember(MemberVO dto) {
		System.out.println("mybatis 사용자 수정");
		return mybatis.update("MemberDAO.updateMember", dto);
	}

	// 삭제
	public int deleteMember(MemberVO dto) {
		System.out.println("mybatis 사용자 삭제");
		return mybatis.delete("MemberDAO.deleteMember", dto);
	}
}
