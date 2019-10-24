package com.dsup.dbmanagement;

import lombok.Data;

@Data
public class DatafileVO {
	private String tablespaceName;
	private String fileName;
	private int bytes;
	private int fileId;
	private int used;
	private int free;
}
