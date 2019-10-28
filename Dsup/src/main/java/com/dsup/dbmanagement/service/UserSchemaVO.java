package com.dsup.dbmanagement.service;

public class UserSchemaVO {

	private String name;
	private String pw;
	private String id;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "UserSchemaVO [name=" + name + ", pw=" + pw + ", id=" + id + "]";
	}
	
	
}
