package com.dsup.dbmanagement;

import lombok.Data;

@Data
public class DatafileVO {
	private String tablespaceName;
	private String fileName;
	private int total; // 전체 용량
	private int used; // 사용 용량
	private int free; // 남은 용량
}
