package com.dsup.member;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String password;
	private String nickname;
	private String eMail;
	private String userDate;
	private String userType;
}
