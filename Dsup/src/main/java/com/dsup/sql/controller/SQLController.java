package com.dsup.sql.controller;

import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.sql.service.SQLService;

@Controller
public class SQLController {
	@Autowired SQLService sqlService;
	
	@RequestMapping("/sqlIndex")
	public String sqlIndex() {
		return "sql/sql_index";
	}
	@RequestMapping("/ShowData.do")
	public String showData(String tag) {
		return "sql/setting/tableview";
	}
	@RequestMapping("/DBread.do")
	@ResponseBody
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.dbRead(request);
		return result;
	}
	@RequestMapping("/Addition.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Addition(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.addition(request);
		return result;
	}
	@RequestMapping("/DBinsert.do")
	@ResponseBody
	public LinkedHashMap<String, Object> DBinsert(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.dbInsert(request);
		return result;
	}
	@RequestMapping("/Filter.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Filter(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.filter(request);
		return result;
	}
	@RequestMapping("/Group.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Group(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.group(request);
		return result;
	}
	@RequestMapping("/Join.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Join(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.join(request);
		return result;
	}
	@RequestMapping("/Order.do")
	@ResponseBody
	public LinkedHashMap<String, Object> order(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.order(request);
		return result;
	}
	@RequestMapping("/Rename.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Rename(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.rename(request);
		return result;
	}
	@RequestMapping("/Union.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Union(HttpServletRequest request) {
		LinkedHashMap<String, Object> result = sqlService.union(request);
		return result;
	}
}
