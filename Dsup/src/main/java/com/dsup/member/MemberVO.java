package com.dsup.member;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String password;
	private String password2;
	private String nickname;
	private String eMail;
	private String userDate;
	private String userType; //관리자(2) / 유저(1)
	private String phonenumber;
	private String payItem;
	private String payService;
	private float volumn; // 윤정 관리자페이지에서 사용자별 용량 조회할 때 쓸 것
	
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
}
