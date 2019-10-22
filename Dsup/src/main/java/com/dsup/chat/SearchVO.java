package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class SearchVO {

	int search;			// 검색번호
	int user_id;		// 유저아이디
	String title;		// 제목
	String contents;	// 내용
	Date write_date;	// 시간
}
