package com.dsup.sql.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpSession;

import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;


//@Repository
public class DAO {
    Connection conn = null; // DB����� ����(����)�� ���� ��ü
    PreparedStatement psmt = null;  // SQL ���� ��Ÿ���� ��ü
    ResultSet rs = null;  // �������� �����Ϳ� ���� ��ȯ���� ���� ��ü

	public DAO(HttpSession session) {
		String schemaid = (String)session.getAttribute("schemaid");
		String schemapwd = (String)session.getAttribute("schemapwd");
		System.out.println("schemaid : " + schemaid);
        String user = "sys as sysdba"; 
        String pw = "yedam4212460";
//		String user = "sys as sysdba";
//       String pw = "orcl";
		if(schemaid==null || schemaid.equals("")){      
			
		}else {
			user = schemaid;
	        pw = schemapwd;	
		}
			
		try {
			System.out.println("DB Connection ID : " + user);
			System.out.println("DB Connection PWD : " + pw);
//			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
            String url = "jdbc:oracle:thin:@39.116.34.40:1521:xe";
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB ����̹� �ε� ���� :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB ���ӽ��� : "+sqle.toString());
        } catch (Exception e) {
    		if(schemaid==null || schemaid.equals("")){
    			System.out.println("Unkonwn error");
    			e.printStackTrace();
    		}
        }
	}
	
	private void close() {
		// TODO Auto-generated method stub
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public LinkedHashMap<String, Object> getData(String sql) {
		// TODO Auto-generated method stub
		//ArrayList<LinkedHashMap<String, Object>> outerList = new ArrayList<LinkedHashMap<String, Object>>();
		
		ArrayList<Object> innerList = null;
		ArrayList<Object> list = null;
		LinkedHashMap<String, Object> innerHash = new LinkedHashMap<String, Object>();
		LinkedHashMap<String, Object> hash = new LinkedHashMap<String, Object>();
		String key;
		String value;
		String select = "";
		
		try {
			String rownum_sql = "SELECT * FROM (" + sql + ") WHERE ROWNUM<=100";
			//System.out.println("rownum_sql : " + rownum_sql);
			//text 부분
			psmt = conn.prepareStatement(rownum_sql);
			//기존 부분
//			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			ResultSetMetaData meta = rs.getMetaData();
			int columnCnt = meta.getColumnCount(); //�÷��� ��
			//System.out.println("==================> colnumCnt : " + columnCnt);
			
			
			////////////////////////////////////////////////////////////////////////////
			
			  LinkedHashMap<String, String> inner_hash = null;
			  ArrayList<Object> temp = new ArrayList<Object>();
			  for(int i=1 ; i<=columnCnt ; i++) { 
				  inner_hash = new LinkedHashMap<String, String>();
				  key = meta.getColumnName(i);
				  value = meta.getColumnTypeName(i);
				  inner_hash.put("key", key);
				  inner_hash.put("value", value);
				  temp.add(inner_hash);
			  } 
			  System.out.println(">>> " +  inner_hash.toString()); 
			  hash.put("COL_NM_TYPE", temp);
			 
			////////////////////////////////////////////////////////////////////////////
			
			/*
			 * LinkedHashMap<String, String> inner_hash = new LinkedHashMap<String, String>(); 
			 * for(int i=1 ; i<=columnCnt ; i++) { key = meta.getColumnName(i);
			 * value = meta.getColumnTypeName(i);
			 * //System.out.println("=============> key : " + key);
			 * //System.out.println("1. is there? : " + inner_hash.containsKey(key));
			 * if(inner_hash.containsKey(key)) { //key = key + "_1";
			 * //System.out.println("2. changed key : " + key); inner_hash.put(key, value);
			 * }else { inner_hash.put(key, value); } } System.out.println(">>> " +
			 * inner_hash.toString()); hash.put("COL_NM_TYPE", inner_hash);
			 */
			
			innerList = new ArrayList<Object>();
			for(int i=1 ; i<=columnCnt ; i++) {
				value = meta.getColumnName(i);
				if(innerList.contains(value)) {
					//value = value + "_1";
					innerList.add(value);
				}else {
					innerList.add(value);
				}
				
				if(i == columnCnt) {
					select = select + "/*|*/" + value + "/*|*/";
				}else {
					select = select + "/*|*/" + value + "/*|*/" + ", ";
				}
			}			
			hash.put("COL_NAME", innerList);
			
			if(sql.contains(" * ")) {
				//System.out.println("문자열 포함");
				//System.out.println("SELECT : " + select);
				sql = sql.replaceFirst("\\*", select);
				System.out.println("Changed Child SQL For Start : \n" + sql);
			}
			hash.put("SQL", sql);
			
			innerList = new ArrayList<Object>();
			for(int i=1 ; i<=columnCnt ; i++) {
				value = meta.getColumnTypeName(i);
				innerList.add(value);

			}
			hash.put("COL_TYPE", innerList);
			
			int index = 1;
			
			innerList =  new ArrayList<Object>();
			innerHash = new LinkedHashMap<String, Object>(); 
			while(rs.next()) {
				list = new ArrayList<Object>();
				 for(int i=1 ; i<=columnCnt ; i++){
					 value =  rs.getString(meta.getColumnName(i));
					 list.add(value);
				 }
				 innerHash.put(Integer.toString(index), list);
				 //System.out.println(index + ". " + innerList.toString());
				 index += 1;
			}
			//해당 sql의 총 row수 가지고 오는 부분
			int rowCount = getRowCount(sql);
			
			hash.put("ROWCOUNT", rowCount);
			hash.put("DATA", innerHash);
			
			//outerList.add(hash);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			//close();
		}
		
		return hash;
	}
	public int getRowCount(String param) {
		int rowCount = 0;
		String sql = "SELECT COUNT(*) AS rowCount FROM (" + param + ")"; 
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				rowCount = rs.getInt("rowCount");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rowCount;
	}

	public ArrayList<String> getTargetTableList() {
		// TODO Auto-generated method stub
		ArrayList<String> targetTableList = new ArrayList<String>();
		
		try {
			String sql = "SELECT table_name FROM user_tables";
			String table_name = "";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				table_name = rs.getString("table_name");
				targetTableList.add(table_name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return targetTableList;
	}

	public ArrayList<HashMap<String, String>> getTargetTableInfo(String targetTable) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = null;
		try {
			String sql = "SELECT column_name, data_type FROM all_tab_columns WHERE table_name=?";
			String colName = "";
			String dataType = "";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, targetTable);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<String, String>();
				colName = rs.getString("column_name");
				dataType = rs.getString("data_type");
				map.put("colName", colName);
				map.put("dataType", dataType);
				System.out.println(list.toString());
				//list.add(map);
				//테이블의 마지막 컬럼부터 가져와서 배열에 넣길레 새로운 컬럼은 제일 처음에 끼워 넣기 식으로 하고 있음 
				list.add(0, map);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			//close();
		}
		
		return list;
	}

	public LinkedHashMap<String, Object> dbInsert(String sql, String target_table) {
		// TODO Auto-generated method stub
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			//close();
		}
		
		String newSql = "SELECT * FROM " + target_table;
		LinkedHashMap<String, Object> result = getData(newSql);
		
		return result;
	}

	public LinkedHashMap<String, Object> dbUpdate(String sql, String target_table) {
		// TODO Auto-generated method stub
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			//close();
		}
		
		String newSql = "SELECT * FROM " + target_table;
		LinkedHashMap<String, Object> result = getData(newSql);
		
		return result;
		
	}

	public String schemaLogin(String id, String pwd) {
		// TODO Auto-generated method stub
		String user_sch_nm = "";
		System.out.println(">>>>>>>>>>>>>>>>>>>>"+ pwd);
		id = id.toUpperCase();
		//pwd = pwd.toUpperCase();
		String sql = "select user_sch_nm from user_sch_tb where user_sch_nm = ? and user_sch_pw = ?";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				user_sch_nm = rs.getString("user_sch_nm");
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
			user_sch_nm = "";
		}finally {
			//close();
		}
		
		return user_sch_nm;
	}

	public LinkedHashMap<String, Object> getOtherData(String sql) {
		// TODO Auto-generated method stub
		ArrayList<Object> innerList = null;
		ArrayList<Object> list = null;
		LinkedHashMap<String, Object> innerHash = new LinkedHashMap<String, Object>();
		LinkedHashMap<String, Object> hash = new LinkedHashMap<String, Object>();
		String key;
		String value;
		String select = "";
		
		try {
			//text 부분
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			ResultSetMetaData meta = rs.getMetaData();
			int columnCnt = meta.getColumnCount();
			int index = 1;
			
			innerList =  new ArrayList<Object>();
			innerHash = new LinkedHashMap<String, Object>(); 
			while(rs.next()) {
				list = new ArrayList<Object>();
				 for(int i=1 ; i<=columnCnt ; i++){
					 value =  rs.getString(meta.getColumnName(i));
					 list.add(value);
				 }
				 innerHash.put(Integer.toString(index), list);
				 index += 1;
			}
			//해당 sql의 총 row수 가지고 오는 부분
			int rowCount = getRowCount(sql);
			
			hash.put("ROWCOUNT", rowCount);
			hash.put("DATA", innerHash);
			
			//outerList.add(hash);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			//close();
		}
		
		return hash;
	}
}
