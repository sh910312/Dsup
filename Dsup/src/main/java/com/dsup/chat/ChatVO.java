package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class ChatVO {

	int chatId;				// 채팅번호 PK
	String userId;			// 유저아이디 FK
	String nickname;		// 닉네임
	String contents;		// 채팅내용
	Date writeDate;			// 채팅시간
	
	
	String orderby;
	
}
