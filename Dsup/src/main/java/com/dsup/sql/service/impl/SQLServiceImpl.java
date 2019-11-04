package com.dsup.sql.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.sql.service.SQLService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class SQLServiceImpl implements SQLService{
	//@Autowired DAO dao;
	public LinkedHashMap<String, Object> dbRead(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
//		String schemaName = (String)session.getAttribute("schemaName");
		System.out.println("\n--- DBread.java ---");
		String sql = (String)request.getParameter("sql").toUpperCase().replaceAll("\n", " ");
		System.out.println("sql : " + sql);
		System.out.println("---------------\n");
		return getData(sql, session);
	}
	
	@Override
	public LinkedHashMap<String, Object> order(HttpServletRequest request, HttpSession session) {
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
	      System.out.println("---------------\n");
	      return getData(sql, session);  	
	}

	@Override
	public LinkedHashMap<String, Object> addition(HttpServletRequest request, HttpSession session) {
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
		System.out.println("---------------\n");
		return getData(sql, session);
	}

	@Override
	public LinkedHashMap<String, Object> filter(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Filter.java ---");
		String child_sql = request.getParameter("sql").toUpperCase().replaceAll("\n", " ");
		String expression = request.getParameter("expression");
		
		//System.out.println("sql = " + child_sql);
		//System.out.println("expression = " + expression);
		
		String sql = "SELECT * " +
			  		 "FROM (" + child_sql + ") " +
			  		 "WHERE " + expression;
		System.out.println("[Maked SQL For Filter] : \n" + sql);
		System.out.println("---------------\n");
		return getData(sql, session);
	}

	@Override
	public LinkedHashMap<String, Object> group(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("---------------\n");
		return null;
	}

	@Override
	public LinkedHashMap<String, Object> join(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Join.java ---");
		String master_sql = request.getParameter("master_sql").toUpperCase().replaceAll("\n", " ");
		String slave_sql = request.getParameter("slave_sql").toUpperCase().replaceAll("\n", " ");
		String join_type = request.getParameter("join_type").toUpperCase().replaceAll("\n", " ");
		String join = "";
		System.out.println("1. SQL1 : " + master_sql);
		System.out.println("2. SQL2 : " + slave_sql);
		System.out.println("3. Join Type : " + join_type);
		ObjectMapper mapper = new ObjectMapper();
		try {
			Map<String, Object> join_key = mapper.readValue(request.getParameter("join_key"), Map.class);
			System.out.println("4. Join Key List : " + join_key.get("join_key"));
			List<Map<String, String>> list = (List)join_key.get("join_key");
			int listLength = list.size();
			for(int i=0; i<listLength; i++) {
				String master = list.get(i).get("master");
				String slave = list.get(i).get("slave");
				if(listLength-1 != i) {
					join += "a." + master + "=b." + slave + " AND ";
				}else {
					join += "a." + master + "=b." + slave;
				}
				System.out.println("5. Join Statement : " + join);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		String sql = "SELECT * " +
		             "FROM (" + master_sql +") a " + join_type + " (" + slave_sql + ") b " +
				     "ON " + join;
		
		
		System.out.println("[Maked SQL For Join] : " + sql );
		System.out.println("---------------\n");
		return getData(sql, session);
	}

	@Override
	public LinkedHashMap<String, Object> rename(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Rename.java ---");
		String sql = request.getParameter("param").toUpperCase().replaceAll("\n", " ");
		
		System.out.println("[Maked SQL For Rename] : \n" + sql);
		System.out.println("---------------\n");
		return getData(sql, session);
	}

	@Override
	public LinkedHashMap<String, Object> union(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- Union.java ---");
		String master_sql = request.getParameter("master_sql").toUpperCase().replaceAll("\n", " ");
		String slave_sql = request.getParameter("slaver_sql").toUpperCase().replaceAll("\n", " ");
		String union_type = request.getParameter("union_type").toUpperCase().replaceAll("\n", " ");
		String sql = "";
		System.out.println("1. master_sql : " + master_sql);
		System.out.println("2. slave_sql : " + slave_sql);
		System.out.println("3. union_type : " + union_type);
		sql = "(" + master_sql + ") "
			  + union_type + " " +
			  "(" + slave_sql  + ")";
		System.out.println("[Maked SQL For Union] : \n" + sql );
		System.out.println("---------------\n");
		return getData(sql, session);
	}
	

///////////////////////////////////////////////////////////////////////////////////////////////////////	
	private LinkedHashMap<String, Object> getData(String sql, HttpSession session) {
		DAO dao = new DAO(session);
		LinkedHashMap<String, Object> data = dao.getData(sql);
		
		return data;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public ArrayList<String> targetTableList(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- TargetTableList.java ---");
		DAO dao = new DAO(session);
		ArrayList<String> data = dao.getTargetTableList();
		System.out.println("[TargetTableTList : ]" + data.toString());
		System.out.println("---------------\n");
		return data;
	}
	
	@Override
	public ArrayList<HashMap<String, String>> targetTableInfo(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- TargetTableInfo.java ---");
		String targetTable = request.getParameter("targetTable").toUpperCase().replaceAll("\n", " ");
		System.out.println("1. get targetTable : " + targetTable);
		DAO dao = new DAO(session);
		ArrayList<HashMap<String, String>> data = dao.getTargetTableInfo(targetTable);
		System.out.println("[TargetTableInfo : ]" + data.toString());
		System.out.println("---------------\n");
		return data;
	}
	
	@Override
	public void dbInsert(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- DBinsert.java ---");
		String targetTable = request.getParameter("target_table").toUpperCase().replaceAll("\n", " ");
		String child_sql = request.getParameter("child_sql").toUpperCase().replaceAll("\n", " ");
		String sql = "INSERT INTO " + targetTable + " " + child_sql;
		DAO dao = new DAO(session);
		dao.dbInsert(sql);
		System.out.println("---------------\n");
	}

	@Override
	public void dbUpdate(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- DBinsert.java ---");
		String sql = request.getParameter("sql");
		System.out.println("1. sql : " + sql);
		DAO dao = new DAO(session);
		dao.dbUpdate(sql);
		System.out.println("---------------\n");
	}

	@Override
	public void dbDelete(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<String> getUserSchemaName(HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("\n--- UserSchemaList.java ---");
		String user_id = (String)session.getAttribute("userId");
		//System.out.println("user_id : " + user_id);
		DAO dao = new DAO(session);
		ArrayList<String> list = dao.getUserSchemaList(user_id);
		System.out.println("---------------\n");
		return list;
	}

	@Override
	public String schemaLogin(String id, String pwd, HttpSession session) {
		// TODO Auto-generated method stub
		
		System.out.println("\n--- schemaLogin.java ---");
		System.out.println("1. Schema ID : " + id);
		System.out.println("2. Schema PWD : " + pwd);
		DAO dao = new DAO(session);
		String loginSuccess = dao.schemaLogin(id, pwd);
		System.out.println("3. LoginSuccess : " + loginSuccess);
		System.out.println("---------------\n");
		if(loginSuccess.equals("success")) {
			session.setAttribute("schemaid", id);
			session.setAttribute("schemapwd", pwd);
		}
		
		return loginSuccess;
	}


}
