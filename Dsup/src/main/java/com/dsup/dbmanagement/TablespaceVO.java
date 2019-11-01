package com.dsup.dbmanagement;

import lombok.Data;

/*
 * 윤정
 * 1022 17:19
 * 테이블스페이스 vo
 */
@Data 
public class TablespaceVO {
	private String tablespaceName;
	private String status; // online, offline, read only
	
	private int total; // 전체 용량
	private int used; // 사용량
	private int free; // 빈 용량
	private float usedPer; // 사용 퍼센트
}
