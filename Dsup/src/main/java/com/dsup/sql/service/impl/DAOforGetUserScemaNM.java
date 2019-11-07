package com.dsup.sql.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DAOforGetUserScemaNM {
	Connection conn = null; 
    PreparedStatement psmt = null;  
    ResultSet rs = null; 

	public DAOforGetUserScemaNM() {
        String user = "sys as sysdba"; 
        String pw = "oracle";
//        String user = "sys as sysdba"; 
//        String pw = "orcl";
		
		try {
			System.out.println("DB Connection ID : " + user);
			System.out.println("DB Connection PWD : " + pw);
//			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
            String url = "jdbc:oracle:thin:@192.168.0.108:1521:xe";
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
	
	public ArrayList<String> getUserSchemaList(String user_id) {
		// TODO Auto-generated method stub
		ArrayList<String> list = new ArrayList<String>();
		String sql = "SELECT a.user_sch_nm FROM user_sch_tb a, dba_users b WHERE UPPER(a.user_sch_nm)=UPPER(b.username) AND a.user_id=? AND b.account_status='OPEN'";
		String schemaNm = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, user_id);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				schemaNm = rs.getString("user_sch_nm");
				list.add(schemaNm);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			close();
		}
		
		return list;
	}
}
