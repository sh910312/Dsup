package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class SearchVO {

	int searchId;		// 검색번호
	String userId;		// 유저아이디
	String title;		// 제목
	String contents;	// 내용
	Date writeDate;		// 시간
	
	String orderby; // 정렬순서
	int[] searchList; // 다건삭제 (여러건 삭제)
	

	// Paging
	int first;
	int last;
	
	
	
	
}
