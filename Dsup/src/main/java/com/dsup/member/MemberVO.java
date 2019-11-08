package com.dsup.member;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String password;
	private String nickname;
	private String eMail;
	private String userDate;
	private String userType; //관리자(2) / 유저(1)
	private String phonenumber;
	
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
}
