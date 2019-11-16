package com.dsup.sql.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface SQLService {
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> addition(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> filter(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> group(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> join(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> order(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> rename(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> union(HttpServletRequest request, HttpSession session);
	public ArrayList<String> targetTableList(HttpServletRequest request, HttpSession session);
	public ArrayList<HashMap<String, String>> targetTableInfo(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> dbInsert(HttpServletRequest request, HttpSession session);
	public LinkedHashMap<String, Object> dbUpdate(HttpServletRequest request, HttpSession session);
	public void dbDelete(HttpServletRequest request, HttpSession session);
	public ArrayList<String> getUserSchemaName(HttpSession session);
	public String schemaLogin(String id, String pwd, HttpSession session);
	public LinkedHashMap<String, Object> getOtherData(HttpServletRequest request, HttpSession session);
}
