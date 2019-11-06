package com.dsup.sql.service.impl;

import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
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
//	        sql = "SELECT * " +
//	              "FROM (" + child_sql + ") " +
//	              "ORDER BY " + order;
			int from_index = child_sql.indexOf("FROM");
			String from = child_sql.substring(from_index, child_sql.length());
			
			sql = "SELECT * " + from + " ORDER BY " + order;
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
		
//		String sql = "SELECT * " +
//			  		 "FROM (" + child_sql + ") " +
//			  		 "WHERE " + expression;
		
		String sql = child_sql + " WHERE " + expression;
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
		System.out.println("1. Join Type : " + join_type);
		
		int masterFromIndex = master_sql.indexOf("FROM");
		String master_select = master_sql.substring(0, masterFromIndex).replace("SELECT ", "");
		//master_select = master_select.replaceAll(" ", "");
		String[] master_cols = master_select.split(",");
		List<String> master_col_list = Arrays.asList(master_cols);
		System.out.println("2. master_col_list : " + master_col_list.toString());
		String master_select_col = "";
		String[] temp;
		for(int i=0; i<master_col_list.size(); i++) {
			if(i != master_col_list.size() -1) {
				if(master_col_list.get(i).contains(" AS ")) {
					temp = master_col_list.get(i).split(" AS ");
					master_select_col += "a." + temp[1] + ", ";
				}else {
					master_select_col += "a." + master_col_list.get(i) + ", ";
				}
			}else {
				if(master_col_list.get(i).contains(" AS ")) {
					temp = master_col_list.get(i).split(" AS ");
					master_select_col += "a." + temp[1];
				}else {
					master_select_col += "a." + master_col_list.get(i);
				}
			}
		}
		
		int slaveFromIndex = slave_sql.indexOf("FROM");
		String slave_select = slave_sql.substring(0, slaveFromIndex).replace("SELECT ", "");
		//slave_select = slave_select.replaceAll(" ", "");
		String[] slave_cols = slave_select.split(",");
		List<String> slave_col_list = Arrays.asList(slave_cols);
		System.out.println("3. slave_col_list : " + slave_col_list.toString());
		String slave_select_col = "";
		String[] temp2;
		for(int i=0; i<slave_col_list.size(); i++) {
			if(i != slave_col_list.size() -1) {
				if(slave_col_list.get(i).contains(" AS ")) {
					temp2 = slave_col_list.get(i).split(" AS ");
					slave_select_col += "a." + temp2[1] + ", ";
				}else {
					slave_select_col += "b." + slave_col_list.get(i) + ", ";
				}
			}else {
				if(slave_col_list.get(i).contains(" AS ")) {
					temp2 = slave_col_list.get(i).split(" AS ");
					slave_select_col += "a." + temp2[1] + ", ";
				}else {
					slave_select_col += "b." + slave_col_list.get(i);
				}
			}
		}		
		
		String select_stmt = master_select_col + ", " + slave_select_col;
		System.out.println("4. select_stmt : " + select_stmt);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			Map<String, Object> join_key = mapper.readValue(request.getParameter("join_key"), Map.class);
			System.out.println("5. Join Key List : " + join_key.get("join_key"));
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
				System.out.println("6. Join Statement : " + join);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		String sql = "SELECT " + select_stmt + " " +
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
		String child_sql = request.getParameter("child_sql").toUpperCase().replaceAll("\n", " ");
		int child_sql_from_index = child_sql.indexOf("FROM");
		//자식 sql의 select절 뒤의 컬럼들만 뽑아냄
		String child_sql_select = child_sql.substring(0, child_sql_from_index).replace("SELECT ", "");
		int blank_index = child_sql_select.lastIndexOf(" ");
		//마지막에 붙은 공백 제거
		child_sql_select = child_sql_select.substring(0, blank_index);
		//컬럼들 ,를 기준으로 각각 뽑아냄
		String[] child_sql_split = child_sql_select.split(",");
		List<String> child_sql_split_list = Arrays.asList(child_sql_split);
		System.out.println("1. child_sql_split_list : " + child_sql_split_list.toString());
		int child_sql_split_length = child_sql_split.length;
		
		String[] from_cols = request.getParameter("from_cols").toUpperCase().replaceAll(" ",  "").split(",");
		List<String> from_cols_list = Arrays.asList(from_cols);
		System.out.println("2. from_cols_list : " + from_cols_list.toString());
		int from_cols_length = from_cols.length;
		
		String[] to_cols = request.getParameter("to_cols").toUpperCase().replaceAll(" ",  "").split(",");
		List<String> to_cols_list = Arrays.asList(to_cols);
		System.out.println("3. to_cols_list : " + to_cols_list.toString());
		
		String select_stmt = "";
		int i=0;
		int j=0;
		
		//자식 sql의 select 컬럼 개수와 add된 테이블의 컬럼 개수가 다르면 보고자 하는 컬럼 개수가 다르다고 판단
		if(child_sql_split_length != from_cols_length) {
			while(true) {
				System.out.println("child_sql_split_list.get(" + i + ") : " + child_sql_split_list.get(i) + " | "  + "from_cols_list.get(" + j + ") : " + from_cols_list.get(j));
				if(child_sql_split_list.get(i).contains(from_cols_list.get(j))) {
					//add된 테이블의 from 컬럼의 전수 조사가 끝나면 while문 종료 
					if(j == to_cols.length-1) {
						select_stmt += child_sql_split_list.get(i);
						System.out.println(">>> select_stmt : " + select_stmt);
						break;
					}else {
						select_stmt += child_sql_split_list.get(i) + ", ";
						System.out.println(">>> select_stmt : " + select_stmt);
					}
					i+=1;
					j+=1;
				}else {
					i+=1;
				}
			}
		}else {
			for(int k=0; k<child_sql_split_list.size(); k++) {
				if(k == child_sql_split_list.size()) {
					select_stmt += child_sql_split_list.get(i);
					System.out.println(">>> select_stmt : " + select_stmt);
					break;
				}else {
					select_stmt += child_sql_split_list.get(i) + ", ";
					System.out.println(">>> select_stmt : " + select_stmt);
				}
			}
		}
	
		
		//변경 하고자 하는 컬럼명 적용 부분
		String to_col = "";
		String from_col = "";
		String[] select_stmt_cols = select_stmt.split(",");
		List<String> select_stmt_col_list = Arrays.asList(select_stmt_cols);
		for(int s=0; s<to_cols_list.size(); s++) {
			from_col = from_cols_list.get(s);
			System.out.println("---------------------------------------");
			System.out.println("from_col : " + from_col);
			if(select_stmt_col_list.get(s).contains("CASE WHEN")) {

			}else {
				to_col = from_col + " AS " + to_cols_list.get(s);
				select_stmt = select_stmt.replaceFirst(from_col, to_col);
			}
			System.out.println("to_col : " + to_col);
			System.out.println("select_stmt : " + select_stmt);
		}
		
		System.out.println("4. step2 > select_stmt : " + select_stmt);
		
		String child_sql_from_stmt = child_sql.substring(child_sql_from_index, child_sql.length());
		String sql = "SELECT " + select_stmt + " " +
		              child_sql_from_stmt; 
		
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
		System.out.println(">>>>>> data : " + data.toString());
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
		System.out.println("user_id : " + user_id);
		DAOforGetUserScemaNM dao = new DAOforGetUserScemaNM();
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
