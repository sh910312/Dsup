package com.dsup.dbmanagement.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class StorageDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	
	public StorageDAO() {
		String user = "sys as sysdba";
		String password = "yedam4212460";
		String url = "jdbc:oracle:thin:@39.116.34.40:1521:xe";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private void close() {
		try {
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	// [윤정 1104] 테이블스페이스 수정
	public void storageUpdate(String sql) {
		String[] sqls = sql.split(";");
		int num = sqls.length;

		System.out.println("--- tablespace update ---");
		try {
			if(num > 0) {
				for (int i = 0; i < num; i++) {
					System.out.println(sqls[i]);
					psmt = conn.prepareStatement(sqls[i]);
					psmt.execute();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}
