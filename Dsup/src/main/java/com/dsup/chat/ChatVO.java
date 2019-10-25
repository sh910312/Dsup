package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class ChatVO {

	int chat_id;			// 채팅번호 PK
	String user_id;			// 유저아이디 FK
	String nickname;		// 닉네임
	String contents;		// 채팅내용
	Date write_date;		// 채팅시간
	
}
