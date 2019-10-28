package com.dsup.sql.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.sql.service.SQLService;

@Controller
public class SQLController {
	@Autowired SQLService sqlService;
	
	@RequestMapping("/sqlIndex")
	public String sqlIndex() {
		return "sql/sql_index";
	}
	@RequestMapping("/DBread.do")
	public String DBread(HttpServletRequest request) {
		sqlService.dbRead(request);
		
		return "sql/sql_index";
	}
	@RequestMapping("/Addition,do")
	public String Addition() {
		return "sql/sql_index";
	}
	@RequestMapping("/DBinsert,do")
	public String DBinsert() {
		return "sql/sql_index";
	}
	@RequestMapping("/Filter,do")
	public String Filter() {
		return "sql/sql_index";
	}
	@RequestMapping("/Group,do")
	public String Group() {
		return "sql/sql_index";
	}
	@RequestMapping("/Join,do")
	public String Join() {
		return "sql/sql_index";
	}
	@RequestMapping("/Order,do")
	public String Order() {
		return "sql/sql_index";
	}
	@RequestMapping("/Rename,do")
	public String Rename() {
		return "sql/sql_index";
	}
	@RequestMapping("/Union,do")
	public String Union() {
		return "sql/sql_index";
	}
}
