package com.dsup.dbmanagement;

import lombok.Data;

@Data
public class UserVO {
	private String id;
	private String password;
	private String defaultTableSpace;
	private String accountStatus;
	private String user;
	private String reservedWords;
	
	
}
