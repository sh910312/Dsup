package com.dsup.sql.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.springframework.stereotype.Repository;

@Repository
public class DAO {
    Connection conn = null; // DB����� ����(����)�� ���� ��ü
    PreparedStatement psmt = null;  // SQL ���� ��Ÿ���� ��ü
    ResultSet rs = null;  // �������� �����Ϳ� ���� ��ȯ���� ���� ��ü

	public DAO() {
		try {
            String user = "scott"; 
            String pw = "tiger";
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB ����̹� �ε� ���� :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB ���ӽ��� : "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
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
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			ResultSetMetaData meta = rs.getMetaData();
			int columnCnt = meta.getColumnCount(); //�÷��� ��
			//System.out.println("colnumCnt = " + columnCnt);
			
			LinkedHashMap<String, String> inner_hash = new LinkedHashMap<String, String>();
			//hash = new LinkedHashMap<String, Object>();
			for(int i=1 ; i<=columnCnt ; i++) {
				key = meta.getColumnName(i);
				value = meta.getColumnTypeName(i);
				//System.out.println(meta.getc());
				inner_hash.put(key, value);
				//col_typ_list.add(COL_TYP);
			}
			hash.put("COL_NM_TYPE", inner_hash);
			
			innerList = new ArrayList<Object>();
			for(int i=1 ; i<=columnCnt ; i++) {
				value = meta.getColumnName(i);
				innerList.add(value);
				if(i == columnCnt) {
					select = select + value;
				}else {
					select = select + value + ", ";
				}
			}			
			hash.put("COL_NAME", innerList);
			
			if(sql.contains("*")) {
				//System.out.println("문자열 포함");
				//System.out.println("SELECT : " + select);
				sql = sql.replace("*", select);
				System.out.println("Changed Child SQL : \n" + sql);
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
			//innerList.add(innerHash);
			hash.put("DATA", innerHash);
			
			//outerList.add(hash);
			System.out.println("\n---------------");
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return hash;
	}
}
