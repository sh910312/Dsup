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
        String user = "sys as sysdba"; 
        String pw = "oracle";
//		String user = "sys as sysdba";
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
	
	public ArrayList<Object> getTableSpaceCondition() {
		// TODO Auto-generated method stub
		String sql = "SELECT   SUBSTR(A.tablespace_name,1,30) AS tablespace_name, " + 
				"         RTRIM(TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1), 'FM9990.99'), '.') AS total_size, " + 
				"         RTRIM(TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1), 'FM9990.99'), '.') AS used_size,  " + 
				"         RTRIM(TO_CHAR(ROUND(SUM(A.sum1)/1024/1024,1), 'FM9990.99'), '.') AS free_size,  " + 
				"         RTRIM(TO_CHAR(ROUND((ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1))/ROUND(SUM(A.total1)/1024/1024,1)*100,2), 'FM9990.99'), '.') AS used_percent " + 
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
				"ORDER BY TO_NUMBER(used_size) DESC";
		
		LinkedHashMap<String, Object> map = null;
		ArrayList<Object> list = new ArrayList<Object>(); ; 
		String tablespace_name = "";
		String total_size = "";
		String used_size = "";
		String free_size = "";
		String used_percent = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				map = new LinkedHashMap<String, Object>();
				tablespace_name = rs.getString("tablespace_name");
				total_size = rs.getString("total_size");
				used_size = rs.getString("used_size");
				free_size = rs.getString("free_size");
				used_percent = rs.getString("used_percent") + "%";
				map.put("tablespace_name", tablespace_name);
				map.put("total_size", total_size);
				map.put("used_size", used_size);
				map.put("free_size", free_size);
				map.put("used_percent", used_percent);
				list.add(map);
				System.out.println(list.toString());
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Object> getUserVolumCondition(){
		String sql = "SELECT RTRIM(TO_CHAR(D.user_id)) AS user_id, RTRIM(TO_CHAR(SUM(C.total_size))) AS total_size, RTRIM(TO_CHAR(SUM(C.used_size))) AS used_size, RTRIM(TO_CHAR(SUM(C.free_size))) AS free_size, \r\n" + 
				"RTRIM(TO_CHAR(ROUND((ROUND(SUM(C.total_size),1)-ROUND(SUM(C.free_size),1))/ROUND(SUM(C.total_size),1)*100,2), 'FM9990.99'), '.') AS used_percent \r\n" + 
				"FROM (SELECT   SUBSTR(A.tablespace_name,1,30) AS tablespace_name, \r\n" + 
				"				         RTRIM(TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1), 'FM9990.99'), '.') AS total_size, \r\n" + 
				"				         RTRIM(TO_CHAR(ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1), 'FM9990.99'), '.') AS used_size, \r\n" + 
				"				         RTRIM(TO_CHAR(ROUND(SUM(A.sum1)/1024/1024,1), 'FM9990.99'), '.') AS free_size, \r\n" + 
				"				         RTRIM(TO_CHAR(ROUND((ROUND(SUM(A.total1)/1024/1024,1)-ROUND(SUM(A.sum1)/1024/1024,1))/ROUND(SUM(A.total1)/1024/1024,1)*100,2), 'FM9990.99'), '.') AS used_percent \r\n" + 
				"				FROM     (SELECT   tablespace_name,0 total1,SUM(BYTES) sum1,MAX(BYTES) maxb,COUNT(BYTES) cnt \r\n" + 
				"				          FROM     dba_free_space \r\n" + 
				"				          GROUP BY tablespace_name \r\n" + 
				"				          UNION \r\n" + 
				"				          SELECT   tablespace_name,SUM(BYTES) total1,0,0,0 \r\n" + 
				"				          FROM     dba_data_files \r\n" + 
				"				          GROUP BY tablespace_name) A, \r\n" + 
				"				          (SELECT * FROM user_tbspc_tb) b \r\n" + 
				"				WHERE A.tablespace_name=b.tablespace_name           \r\n" + 
				"				GROUP BY A.tablespace_name \r\n" + 
				"				ORDER BY TO_NUMBER(used_size) DESC) C,\r\n" + 
				"                (SELECT user_id, tablespace_name FROM user_tbspc_tb) D\r\n" + 
				"WHERE C.tablespace_name=D.tablespace_name\r\n" + 
				"GROUP BY D.user_id";
		
		LinkedHashMap<String, Object> map = null;
		ArrayList<Object> list = new ArrayList<Object>(); ; 
		String user_id = "";
		String total_size = "";
		String used_size = "";
		String free_size = "";
		String used_percent = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				map = new LinkedHashMap<String, Object>();
				user_id = rs.getString("user_id");
				total_size = rs.getString("total_size");
				used_size = rs.getString("used_size");
				free_size = rs.getString("free_size");
				used_percent = rs.getString("used_percent") + "%";
				map.put("user_id", user_id);
				map.put("total_size", total_size);
				map.put("used_size", used_size);
				map.put("free_size", free_size);
				map.put("used_percent", used_percent);
				list.add(map);
				System.out.println(list.toString());
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Object> getDataFileVolumeCondition(){
		String sql = "SELECT d.tablespace_name AS tablespace_name\r\n" + 
				"    ,REGEXP_SUBSTR(d.file_name, '[^\\]+', 1, 9) AS file_name\r\n" + 
				"    ,RTRIM(TO_CHAR(ROUND(SUM(d.bytes)/1024/1024,1), 'FM9990.99'), '.') AS total_size\r\n" + 
				"    ,RTRIM(TO_CHAR(ROUND(SUM(f.bytes)/1024/1024,1), 'FM9990.99'), '.') AS free_size\r\n" + 
				"    ,RTRIM(TO_CHAR(ROUND(SUM(d.bytes)/1024/1024,1)-ROUND(SUM(f.bytes)/1024/1024,1), 'FM9990.99'), '.') AS used_size\r\n" + 
				"    ,RTRIM(TO_CHAR(ROUND((ROUND(SUM(d.bytes)/1024/1024,1)-ROUND(SUM(f.bytes)/1024/1024,1))/ROUND(SUM(d.bytes)/1024/1024,1)*100,2), 'FM9990.99'), '.') AS used_percent \r\n" + 
				"FROM dba_data_files d, dba_free_space f, user_tbspc_tb g\r\n" + 
				"WHERE d.file_id = f.file_id(+) AND d.tablespace_name=g.tablespace_name\r\n" + 
				"GROUP BY d.tablespace_name, d.file_name\r\n" + 
				"ORDER BY d.tablespace_name";
		
		LinkedHashMap<String, Object> map = null;
		ArrayList<Object> list = new ArrayList<Object>(); ; 
		String tablespace_name = "";
		String file_name = "";
		String total_size = "";
		String used_size = "";
		String free_size = "";
		String used_percent = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				map = new LinkedHashMap<String, Object>();
				tablespace_name = rs.getString("tablespace_name");
				file_name = rs.getString("file_name");
				total_size = rs.getString("total_size");
				used_size = rs.getString("used_size");
				free_size = rs.getString("free_size");
				used_percent = rs.getString("used_percent") + "%";
				map.put("tablespace_name", tablespace_name);
				map.put("file_name", file_name);
				map.put("total_size", total_size);
				map.put("used_size", used_size);
				map.put("free_size", free_size);
				map.put("used_percent", used_percent);
				list.add(map);
				System.out.println(list.toString());
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
}
