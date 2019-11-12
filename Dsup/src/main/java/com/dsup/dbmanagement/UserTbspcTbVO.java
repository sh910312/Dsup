package com.dsup.dbmanagement;

import lombok.Data;

// [윤정1030] user_tbspc_tb 테이블

@Data
public class UserTbspcTbVO {
	private String tablespaceName;
	private String userId;
	private double volumn;
}
