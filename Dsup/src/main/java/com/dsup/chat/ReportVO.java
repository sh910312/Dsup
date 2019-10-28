package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {

	String reporter;		// 신고자
	int banType;			// 신고타입
	int bnaTypeId;		// 신고당하는사람
	String contents;		// 신고사유
	Date writeDate;		// 신고한 날짜
	
}
