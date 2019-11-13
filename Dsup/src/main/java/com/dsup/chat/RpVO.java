package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class RpVO {

	int rpId;				// 신고번호
	String userId;			// 신고자
	String rpUserId;		// 신고당하는사람
	int rpType;				// 신고타입()
	Date rpDate;			// 신고한 날짜
	String rpContents;		// 신고사유
	int boardNum;			// 게시글 번호
	
	
	String orderby; 		// 정렬순서
	
	
	// paging
	int first;
	int last;
}
