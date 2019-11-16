package com.dsup.sql.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.sql.service.SQLService;

@Controller
public class SQLController {
	@Autowired SQLService sqlService;
	
	@RequestMapping("/getOtherData")
	@ResponseBody
	public LinkedHashMap<String, Object> getOtherData(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.getOtherData(request, session);
		
		return result;
	}
	@RequestMapping("/Connection")
	@ResponseBody
	public String schemaLogin(String id, String pwd, HttpSession session) {
		String loginSucess = sqlService.schemaLogin(id, pwd, session);
		return loginSucess;
	}
	@RequestMapping("/Disconnection")
	@ResponseBody
	public String sqlIndex(HttpSession session) {
		session.removeAttribute("schemaid");
		session.removeAttribute("schemapwd");
		return null;
	}
	
	@RequestMapping("/sqlIndex")
	public String sqlIndex(Model model, HttpSession session) {
		ArrayList<String> schemaList = sqlService.getUserSchemaName(session);
		model.addAttribute("schemaList", schemaList);
		//String schemaid = (String)session.getAttribute("schemaid");
		
		return "sql/sql_index";
	}
	//테스트용
	@RequestMapping("/ShowData.do")
	public String showData(Model model, HttpServletRequest request) {
		String sql = request.getParameter("sql");
		String rowCount = request.getParameter("rowCount");
		model.addAttribute("sql", sql);
		model.addAttribute("rowCount", rowCount);
		
		return "sql/setting/tableview";
	}
	//기존 방법
//	@RequestMapping("/ShowData.do")
//	public String showData(String tag) {
//		return "sql/setting/tableview";
//	}
	@RequestMapping("/DBread.do")
	@ResponseBody
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.dbRead(request, session);
		return result;
	}
	@RequestMapping("/Addition.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Addition(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.addition(request, session);
		return result;
	}
	@RequestMapping("/Filter.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Filter(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.filter(request, session);
		return result;
	}
	@RequestMapping("/Group.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Group(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.group(request, session);
		return result;
	}
	@RequestMapping("/Join.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Join(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.join(request, session);
		return result;
	}
	@RequestMapping("/Order.do")
	@ResponseBody
	public LinkedHashMap<String, Object> order(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.order(request, session);
		return result;
	}
	@RequestMapping("/Rename.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Rename(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.rename(request, session);
		return result;
	}
	@RequestMapping("/Union.do")
	@ResponseBody
	public LinkedHashMap<String, Object> Union(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.union(request, session);
		return result;
	}
	@RequestMapping("/TargetTableList.do")
	@ResponseBody
	public ArrayList<String> TargetTableList(HttpServletRequest request, HttpSession session) {
		ArrayList<String> result = sqlService.targetTableList(request, session);
		return result;
	}
	@RequestMapping("/TargetTableInfo.do")
	@ResponseBody
	public ArrayList<HashMap<String, String>> TargetTableInfo(HttpServletRequest request, HttpSession session) {
		ArrayList<HashMap<String, String>> result = sqlService.targetTableInfo(request, session);
		return result;
	}
	@RequestMapping("/DBinsert.do")
	@ResponseBody
	public LinkedHashMap<String, Object> DBinsert(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.dbInsert(request, session);
		return result;
	}
	@RequestMapping("/DBupdate.do")
	@ResponseBody
	public LinkedHashMap<String, Object> DBupdate(HttpServletRequest request, HttpSession session) {
		LinkedHashMap<String, Object> result = sqlService.dbUpdate(request, session);
		return result;
	}
	@RequestMapping("/DBdelete.do")
	@ResponseBody
	public void DBdelete(HttpServletRequest request, HttpSession session) {
		 sqlService.dbDelete(request, session);
	}
}
