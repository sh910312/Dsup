package com.dsup.dbmanagement;

public class UserVO {
	private String id;
	private String password;
	private String defaultTableSpace;
	private String temporaryTableSpace;
	
	
	public String getTemporaryTableSpace() {
		return temporaryTableSpace;
	}
	public void setTemporaryTableSpace(String temporaryTableSpace) {
		this.temporaryTableSpace = temporaryTableSpace;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
	public String getDefaultTableSpace() {
		return defaultTableSpace;
	}
	public void setDefaultTableSpace(String defaultTableSpace) {
		this.defaultTableSpace = defaultTableSpace;
	}
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", password=" + password + "]";
	}

	
}
