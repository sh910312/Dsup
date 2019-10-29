package com.dsup.sql.service;

import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

public interface SQLService {
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request);
	public LinkedHashMap<String, Object> addition(HttpServletRequest request);
	public LinkedHashMap<String, Object> dbInsert(HttpServletRequest request);
	public LinkedHashMap<String, Object> filter(HttpServletRequest request);
	public LinkedHashMap<String, Object> group(HttpServletRequest request);
	public LinkedHashMap<String, Object> join(HttpServletRequest request);
	public LinkedHashMap<String, Object> order(HttpServletRequest request);
	public LinkedHashMap<String, Object> rename(HttpServletRequest request);
	public LinkedHashMap<String, Object> union(HttpServletRequest request);
}
