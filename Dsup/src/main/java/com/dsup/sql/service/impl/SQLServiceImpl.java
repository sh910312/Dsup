package com.dsup.sql.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.sql.service.SQLService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class SQLServiceImpl implements SQLService{
	@Autowired DAO dao;
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		System.out.println("\n--- DBread.java ---");
		String sql = (String)request.getParameter("sql").toUpperCase().replaceAll("\n", " ");
		System.out.println("sql : " + sql);
		
		return getData(sql);
	}
	
	@Override
	public LinkedHashMap<String, Object> order(HttpServletRequest request) {
		System.out.println("\n--- Order.java ---");
		ObjectMapper mapper = new ObjectMapper();
		String sql = "";
	      try {
			Map<String, Object> object = mapper.readValue(request.getParameter("param"), Map.class);
			String child_sql = request.getParameter("child_sql");
			System.out.println("test : " + object.get("param"));
			List<Map<String, String>> list = (List)object.get("param");
			//String str = "";
			String order = "";
			int length = list.size();
			System.out.println("length : " + length);
			for(int i=0; i<length; i++) {
				String key = list.get(i).get("key");
				String val = list.get(i).get("value");
				//System.out.println("key : " + key + " | " + "val : " + val);
	        	if(length-1 != i) {
	        		order += key + " " + val + ", ";
	        	}else {
	        		order += key + " " + val;            		
	        	}
			}
	        //order += " " + str;
	        sql = "SELECT * " +
	              "FROM (" + child_sql + ") " +
	              "ORDER BY " + order;
	        System.out.println("[Maked SQL For Order] : \n" + sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
	      
	      return getData(sql);  	
	}

	@Override
	public LinkedHashMap<String, Object> addition(HttpServletRequest request) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Addition.java ---");
		String child_sql = request.getParameter("sql").toUpperCase();
		String expression = request.getParameter("expression").toUpperCase().replaceAll("\n", " ");
		expression = expression.replace("IF", "CASE WHEN");
		String colName = request.getParameter("colName").toUpperCase();
		String [] operaterList = {"MIN", "MAX", "AVG", "SUM"};
		String sql= "";
		//System.out.println("1. sql = " + child_sql);
		//System.out.println("2. expression = " + expression);
		//System.out.println("3. colName = " + colName);
		boolean operater_usage = false;
		for(String operater : operaterList) {
			//System.out.println("operater = " + operater);
			operater_usage = expression.contains(operater);
			if(operater_usage == true) {
				break;
			}
		}
		//System.out.println("4. operater usage? " + operater_usage);
		
		if(child_sql.contains(colName)) {
			//기존의 컬럼의 값을 바꾸고 싶어 하는 경우
			if(operater_usage) {
				
			}else {
				expression = expression  + " AS " + colName;
				sql = child_sql.replaceFirst(colName, expression);
			}
		}else {
			//새로운 컬럼을 추가 하고 싶은 경우
			if(operater_usage) {
				sql = "SELECT * " +
			          "FROM " + "(" + child_sql +") CROSS JOIN " +
			                    "(SELECT " + expression + " AS " + colName + " " +
			                     "FROM " + "(" + child_sql + "))";
			}else {
				expression = ", " + expression + " AS " + colName + " FROM";
				sql = child_sql.replaceFirst(" FROM", expression);
			}
		}
		System.out.println("[Maked SQL For Addition] : \n" + sql);
		
		return getData(sql);
	}

	@Override
	public LinkedHashMap<String, Object> dbInsert(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public LinkedHashMap<String, Object> filter(HttpServletRequest request) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Filter.java ---");
		String child_sql = request.getParameter("sql");
		String expression = request.getParameter("expression");
		
		//System.out.println("sql = " + child_sql);
		//System.out.println("expression = " + expression);
		
		String sql = "SELECT * " +
			  		 "FROM (" + child_sql + ") " +
			  		 "WHERE " + expression;
		System.out.println("[Maked SQL For Filter] : \n" + sql);
		
		return getData(sql);
	}

	@Override
	public LinkedHashMap<String, Object> group(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public LinkedHashMap<String, Object> join(HttpServletRequest request) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Join.java ---");
		String sql_1 = request.getParameter("sql_1");
		String sql_2 = request.getParameter("sql_2");
		String join_key_1 = request.getParameter("join_key_1");
		String join_key_2 = request.getParameter("join_key_2");
		String join_type = request.getParameter("join_type");
		System.out.println("1. SQL1 : " + sql_1);
		System.out.println("2. SQL2 : " + sql_2);
		System.out.println("3. Join Key 1 : " + join_key_1);
		System.out.println("4. Join Key 2 : " + join_key_2);
		System.out.println("5. Join Type : " + join_type);
//		System.out.println("sql_1 : " + sql_1 + " | " + "sql_2 : " + sql_2 + " | " + 
//		                   "join_key_1 : " + join_key_1 + " | " + "join_key_2 : " + join_key_2 + " | " +
//		                   "join_type : " + join_type);
		
		String sql = "SELECT * " +
		             "FROM (" + sql_1 +") a " + join_type + " (" + sql_2 + ") b " +
				     "ON a." + join_key_1 + "=b." + join_key_2;
		System.out.println("[Maked SQL For Join] : " + sql );
		
		return getData(sql);
	}

	@Override
	public LinkedHashMap<String, Object> rename(HttpServletRequest request) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Rename.java ---");
		String sql = request.getParameter("param");
		
		System.out.println("[Maked SQL For Rename] : \n" + sql);
		
		return getData(sql);
	}

	@Override
	public LinkedHashMap<String, Object> union(HttpServletRequest request) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Union.java ---");
		String master_sql = request.getParameter("master_sql");
		String slaver_sql = request.getParameter("slaver_sql");
		String union_type = request.getParameter("union_type");
		String sql = "";
		
		sql = master_sql +
			 " " + union_type + " " +
			  slaver_sql;
		System.out.println("[Maked SQL For Union] : \n" + sql );
		
		return getData(sql);
	}
	
	private LinkedHashMap<String, Object> getData(String sql) {
		DAO dao = new DAO();
		LinkedHashMap<String, Object> data = dao.getData(sql);
		
		return data;
	}
}
