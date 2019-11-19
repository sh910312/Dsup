package com.dsup.dbmanagement;

import lombok.Data;

@Data
public class BackupVO {
	private String backupFileNm;
	private String userId;
	private String backupDate;
	private String backupComment;
	private String retentionPeriod;
}
