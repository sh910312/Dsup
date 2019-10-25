package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {

	String user_id; 	// 유저아이디
	String pw;			// 비밀번호
	String nickname;	// 닉네임
	String e_mail;		// 이메일
	Date user_date;		// 가입날짜
	int user_type; 		// 1번 일반유저(디폴트) 2번 관리자
	
}
