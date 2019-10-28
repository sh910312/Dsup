package com.dsup.sql.service.impl;

import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.sql.service.SQLService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class SQLServiceImpl implements SQLService{
	@Autowired DAO dao;
	public String dbRead(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		System.out.println("\n--- DBread.java ---");
		String sql = (String)request.getParameter("sql");
		System.out.println("sql : " + sql);
		
		return getJSON(sql);
	}
	
	private String getJSON(String sql) {
		DAO dao = new DAO();
		LinkedHashMap<String, Object> data = dao.getData(sql);
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(json);
				
		return json;
	}
}
