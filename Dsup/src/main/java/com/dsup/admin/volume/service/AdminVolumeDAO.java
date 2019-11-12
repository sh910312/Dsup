package com.dsup.admin.volume.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.springframework.stereotype.Repository;

@Repository
public class AdminVolumeDAO {
	Connection conn = null; // DB����� ����(����)�� ���� ��ü
    PreparedStatement psmt = null;  // SQL ���� ��Ÿ���� ��ü
    ResultSet rs = null;  // �������� �����Ϳ� ���� ��ȯ���� ���� ��ü

	public AdminVolumeDAO() {
//        String user = "sys as sysdba"; 
//        String pw = "oracle";
		String user = "sys as sysdba";
        String pw = "orcl";
			
		try {
			System.out.println("DB Connection ID : " + user);
			System.out.println("DB Connection PWD : " + pw);
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
//            String url = "jdbc:oracle:thin:@192.168.0.108:1521:xe";
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB ����̹� �ε� ���� :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB ���ӽ��� : "+sqle.toString());
        } catch (Exception e) {
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
	
	public LinkedHashMap<String, Object> getTableSpaceCondition() {
		// TODO Auto-generated method stub
		String sql = "SELECT   SUBSTR(A.tablespace_name,1,30) AS tablespace_name, " + 
				"         TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1)) AS total_size, " + 
				"         TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1)) AS used_size, " + 
				"         TO_CHAR(ROUND(SUM(A.sum1)/1024/1024,1)) AS free_size, " + 
				"         TO_CHAR(ROUND((ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1))/ROUND(SUM(A.total1)/1024/1024,1)*100,2)) AS used_percent " + 
				"FROM     (SELECT   tablespace_name,0 total1,SUM(BYTES) sum1,MAX(BYTES) maxb,COUNT(BYTES) cnt " + 
				"          FROM     dba_free_space " + 
				"          GROUP BY tablespace_name " + 
				"          UNION " + 
				"          SELECT   tablespace_name,SUM(BYTES) total1,0,0,0 " + 
				"          FROM     dba_data_files " + 
				"          GROUP BY tablespace_name) A, " + 
				"          (SELECT * FROM user_tbspc_tb) b " + 
				"WHERE A.tablespace_name=b.tablespace_name           " + 
				"GROUP BY A.tablespace_name " + 
				"ORDER BY total_size DESC";
		
		LinkedHashMap<String, Object> map = null;
		ArrayList<Object> list = new ArrayList<Object>(); ; 
		String tablespace_name = "";
		String total_size = "";
		String used_size = "";
		String used_percent = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				map = new LinkedHashMap<String, Object>();
				tablespace_name = rs.getString("tablespace_name");
				total_size = rs.getString("total_size");
				used_size = rs.getString("used_size");
				used_percent = rs.getString("used_percent");
				map.put("tablespace_name", tablespace_name);
				map.put("total_size", total_size);
				map.put("used_size", used_size);
				map.put("used_percent", used_percent);
				list.add(map);
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}

}
