package com.dsup.chat;

import java.sql.Date;

import lombok.Data;

@Data
public class ReVO {

	int reId;			// 댓글번호
	int searchId;		// 게시글번호
	String userId;		// 유저아이디
	String contents;	// 댓글내용
	Date writeDate;		// 댓글시간
	
	String orderby; // 정렬순서
	
}
