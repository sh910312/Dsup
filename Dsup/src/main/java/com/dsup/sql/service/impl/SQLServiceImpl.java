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
			//오더바이 대상 컬럼과 오더바이 종류 쌍
			List<Map<String, String>> list = (List)object.get("param");
			String orderby = "";
			int length = list.size();
			System.out.println("length : " + length);
			for(int i=0; i<length; i++) {
				String column = list.get(i).get("key");
				String orderType = list.get(i).get("value");
				//System.out.println("key : " + key + " | " + "val : " + val);
	        	if(length-1 != i) {
	        		orderby += column + " " + orderType + ", ";
	        	}else {
	        		orderby += column + " " + orderType;            		
	        	}
			}
			
	        sql = "SELECT * " +
	              "FROM (" + child_sql + ") " +
	              "ORDER BY " + orderby;
			//union 이후 orderby 할 경우 이상해짐 - 2019.11.07
//			int from_index = child_sql.indexOf("FROM");
//			String from = child_sql.substring(from_index, child_sql.length());
//			sql = "SELECT * " + from + " ORDER BY " + orderby;
			
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
		ObjectMapper mapper = new ObjectMapper();
		String sql = "";
		
		//191108 에러 1.6 때문 수정한 부분 + 여러가지 조건들 받을 수 있도록 수정
		try {
			Map<String, Object> object = mapper.readValue(request.getParameter("param"), Map.class);
			//자식 sql 변수
			String child_sql = request.getParameter("sql").toUpperCase();
			System.out.println("1. child_sql = " + child_sql);
			int child_sqlFromIndex = child_sql.indexOf("FROM");
			String child_sql_select = child_sql.substring(0, child_sqlFromIndex).replace("SELECT ", "");
			int last_blank_index = child_sql_select.lastIndexOf(" ");
			child_sql_select = child_sql_select.substring(0, last_blank_index);
			System.out.println(">1.0 child_sql_select : " + child_sql_select);
			//master_select = master_select.replaceAll(" ", "");
			String[] child_sql_cols = child_sql_select.split(",");
			List<String> temp_child_sql_cols_list = new ArrayList<String>(Arrays.asList(child_sql_cols));
			List<String> child_sql_cols_list = temp_child_sql_cols_list;
			//master select문 컬럼들 앞에 공백 없애는 부분
			for(int i=0; i<child_sql_cols_list.size(); i++) {
				String str = temp_child_sql_cols_list.get(i).replaceFirst(" ", "");
				child_sql_cols_list.set(i, str);
				String col = child_sql_cols_list.get(i);
				System.out.println(">1.1." + i + " col : " + col);
				//자식 컬럼에서 마침표와 AS 빼고 순수 컬럼명만 가지고 오는 부분
				if(col.contains(" AS ")) {
					//AS 붙은 컬럼 처리
					String[] split = col.split(" AS ");
					col = split[1];
					child_sql_cols_list.set(i, col);
				}else if(col.contains(".")){
					//마침표 붙은 컬럼 처리
					String[] split = col.split("\\.");
					col = split[1];
					child_sql_cols_list.set(i, col);
				}else {
					//마침표와 AS 빼고 순수 컬럼들 처리
					child_sql_cols_list.set(i, col);
				}
			}
		
			System.out.println(">> 1.2 child_sql_cols_list : " + child_sql_cols_list.toString());
			List<Map<String, String>> list = (List)object.get("param");
			int length = list.size();
			//colName과 expression list 변수들
			ArrayList<String> colName_list = new ArrayList<String>();
			ArrayList<String> expression_list = new ArrayList<String>();
			for(int i=0; i<length; i++) {
				colName_list.add(list.get(i).get("colName"));
				expression_list.add(list.get(i).get("expression"));
			}
			System.out.println("2. expression_list = " + expression_list.toString());
			System.out.println("3. colName_list = " + colName_list.toString());
			List<String> select_stmt_list = new ArrayList<String>();
			//인스턴스는 변수 째로 넣으면 주소값만 넣어져서 복사본에 add()시켜도 원본으 사이즈도 같이 늘어남
			select_stmt_list.addAll(child_sql_cols_list);
			//자식 sql의 컬럼들과 비교하여 expression 처리하는 부분 : 추가할 컬럼이 from절의 컬럼과 같은 경우 처리 부분
			for(int i=0; i<colName_list.size(); i++) {
				for(int j=0; j<child_sql_cols_list.size(); j++) {
					//추가할 컬럼이 from절의 컬럼과 같을 경우
					if(colName_list.get(i).equals(child_sql_cols_list.get(j))) {
						//from점의 컬럼명관 동일하 컬럼에 CASE WHEN 있을 경우 컬럼명에 AS 붙여서 select문에 넣어야됨 : 왜?? () 에러 방지 때문에
						if(expression_list.get(i).contains("IF ")) {
							//추가 하려는 컬럼명의 index와 expression의 index는 동일 하기 때문에 똑같은 index사용해서 값을 뽑아옴
							String exp = expression_list.get(i).replace("IF", "CASE WHEN");
							exp = exp + " AS " + colName_list.get(i);
							select_stmt_list.set(j, exp);
							//컬럼이 동일하 녀석들 추가 컬럼 이름 list와 표현 list에서 제거 : 하나의 for문에 돌릴려니 자식 컬럼 개수만큼 계속 추가되서 나중에 남은 것들 따로 할 생각
							colName_list.remove(i);
							expression_list.remove(i);
							System.out.println(">3." + j + ".1 select_stmt_list : " + select_stmt_list.toString());
						}else if(checkOperaterExp(expression_list.get(i))){
							//추가하려는 컬럼의 expression이 함수 일 경우
							String exp = "SELECT " + expression_list.get(i) + " FROM (" + child_sql + ")";
							exp = "(" + exp + ") AS " + colName_list.get(i);
							select_stmt_list.set(j, exp);
							colName_list.remove(i);
							expression_list.remove(i);
							System.out.println(">3." + j + ".2 select_stmt_list : " + select_stmt_list.toString());
						}else {
							//추가하려는 컬럼의 expression이 숫자이든 문자이든 상관없이 그냥 추가 시키면 그만임
							String exp = expression_list.get(i) + " AS " + colName_list.get(i);
							select_stmt_list.set(j, exp);
							colName_list.remove(i);
							expression_list.remove(i);
							System.out.println(">3." + j + ".3 select_stmt_list : " + select_stmt_list.toString());
						}
					}
				}
			}
			//추가할 컬럼이 from절의 컬럼과 다를 경우 처리 부분
			for(int i=0; i<colName_list.size(); i++) {
				if(expression_list.get(i).contains("IF ")) {
					//추가 하려는 컬럼명의 index와 expression의 index는 동일 하기 때문에 똑같은 index사용해서 값을 뽑아옴
					String exp = expression_list.get(i).replace("IF", "CASE WHEN");
					exp = exp + " AS " + colName_list.get(i);
					select_stmt_list.add(exp);
					System.out.println(">>>3." + i + ".1 select_stmt_list : " + select_stmt_list.toString());
				}else if(checkOperaterExp(expression_list.get(i))){
					//추가하려는 컬럼의 expression이 함수 일 경우
					String exp = "SELECT " + expression_list.get(i) + " FROM (" + child_sql + ")";
					exp = "(" + exp + ") AS " + colName_list.get(i);
					System.out.println("exp : " + exp);
					select_stmt_list.add(exp);
					System.out.println(">>>3." + i + ".2 select_stmt_list : " + select_stmt_list.toString());
				}else {
					//추가하려는 컬럼의 expression이 숫자이든 문자이든 상관없이 그냥 추가 시키면 그만임
					String exp = expression_list.get(i) + " AS " + colName_list.get(i);
					select_stmt_list.add(exp);
					System.out.println(">>>3." + i + ".3 select_stmt_list : " + select_stmt_list.toString());
				}
			}
			
			//완성 sql문의 select 구문 만드는 부분
			String select_stmt = "";
			for(int i=0; i<select_stmt_list.size(); i++){
				if(i == select_stmt_list.size()-1) {
					select_stmt += select_stmt_list.get(i);
				}else {
					select_stmt += select_stmt_list.get(i) + ", ";
				}
			}
			
			sql = "SELECT " + select_stmt + " " +
				  "FROM (" + child_sql + ") "; 
			
			//191108 여러가지 조합의 expression을 받지 못하여 수정함
	//		String expression = request.getParameter("expression").toUpperCase().replaceAll("\n", " ");
	//		expression = expression.replace("IF", "CASE WHEN");
	//		String colName = request.getParameter("colName").toUpperCase();
			
			System.out.println("[Maked SQL For Addition] : \n" + sql);
			System.out.println("---------------\n");
			//191108 여러가지 조합의 expression을 받지 못하여 수정함
//			boolean operater_usage = false;
//			for(String operater : operaterList) {
//				//System.out.println("operater = " + operater);
//				operater_usage = expression.contains(operater);
//				if(operater_usage == true) {
//					break;
//				}
//			}
//			
//			if(child_sql.contains(colName)) {
//				//기존의 컬럼의 값을 바꾸고 싶어 하는 경우
//				if(operater_usage) {
//					
//				}else {
//					expression = expression  + " AS " + colName;
//					sql = child_sql.replaceFirst(colName, expression);
//				}
//			}else {
//				if(operater_usage) {
//					//새로운 컬럼에 오퍼레이더 함수를 사용하여 추가하고 싶은 경우
//					//select * from (child_sql)이 안되는 이유? 기존 컬럼명을 바꾸는 거랑 operateor 쓴거랑 case when 쓴거랑 한꺼번에 올 수도 있어서인데 얘도 문제가 생길거 같은데??? - 191108
//					sql = "SELECT * " +
//				          "FROM " + "(" + child_sql +") CROSS JOIN " +
//				                    "(SELECT " + expression + " AS " + colName + " " +
//				                     "FROM " + "(" + child_sql + "))";
//				}else {
//					//새로운 컬럼에 case when 쓰고 싶은 경우
//					//select * from (child_sql)이 안되는 이유? 기존 컬럼명을 바꾸는 거랑 operateor 쓴거랑 case when 쓴거랑 한꺼번에 올 수도 있어서
//					expression = ", " + expression + " AS " + colName + " FROM";
//					sql = child_sql.replaceFirst(" FROM", expression);
//				}
//			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		return getData(sql, session);
	}
	
	private boolean checkOperaterExp(String expression) {
		boolean result = false;
		String[] temp_operaterList = {"MIN", "MAX", "AVG", "SUM"};
		List<String> operaterList = Arrays.asList(temp_operaterList);
		System.out.println(">> checkOperaterExp().expression : " + expression);
		for(String operater : operaterList) {
			if(expression.contains(operater)) {
				result = expression.contains(operater);
				System.out.println(">> checkOperaterExp().operater : " + operater);
				break;
			}
		}
		
		return result;
	}
	
	private boolean CheckNumber(String str){
		char check;
		
		if(str == null || str.equals("")){
			//문자열이 공백인지 확인
			return false;
		}
		
		for(int i = 0; i<str.length(); i++){
			check = str.charAt(i);
			if( check < 48 || check > 58)
			{
				//해당 char값이 숫자가 아닐 경우
				return false;
			}
			
		}		
		return true;
	}
	
//	private String colMakerForAddition(String str) {
//		String result = "";
//		if(str.contains("IF")) {
//			String exp = str.replace("IF", "CASE WHEN");
//			result = exp;
//		}else if(CheckNumber(str)){
//			//expression값이 int형인지 판단
//			result = str;
//		}else {
//			//expression : operator 사용한 녀석 처리
//			result = str
//		}
//		
//		return result;
//	}

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
		//191107 3중 조인 시 애매한 컬럼 명 에러 - 별칭으로 줄 master와 slave 키들 request로 받아와야됨
		String maset_key = request.getParameter("maset_key");
		String slave_key = request.getParameter("slave_key");
		System.out.println("1. Join Type : " + join_type);
		
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, String>> on_stmt_list = null;
		String master_on_col = "";
		String slave_on_col = "";
		try {
			Map<String, Object> join_key = mapper.readValue(request.getParameter("join_key"), Map.class);
			System.out.println("5. Join Key List : " + join_key.get("join_key"));
			on_stmt_list = (List)join_key.get("join_key");
			int listLength = on_stmt_list.size();
			for(int i=0; i<listLength; i++) {
				master_on_col = on_stmt_list.get(i).get("master");
				slave_on_col = on_stmt_list.get(i).get("slave");
				if(listLength-1 != i) {
					join += "a." + master_on_col + "=b." + slave_on_col + " AND ";
				}else {
					join += "a." + master_on_col + "=b." + slave_on_col;
				}
				System.out.println("6. Join Statement : " + join);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		int masterFromIndex = master_sql.indexOf("FROM");
		String master_select = master_sql.substring(0, masterFromIndex).replace("SELECT ", "");
		int maset_select_last_blank_index = master_select.lastIndexOf(" ");
		master_select = master_select.substring(0, maset_select_last_blank_index);
		System.out.println("master_select : " + master_select);
		//master_select = master_select.replaceAll(" ", "");
		String[] master_cols = master_select.split(",");
		List<String> master_col_list = Arrays.asList(master_cols);
		//master select문 컬럼들 앞에 공백 없애는 부분
		for(int i=0; i<master_col_list.size(); i++) {
			String str = master_col_list.get(i).replaceFirst(" ", "");
			//왠지 마스터 컬럼에 as 붙어 있으면 오류 날거 같은데?? - 191108
			if(str.contains(".")) {
				String[] array = str.split("\\.");
				str = array[1];
			}
			master_col_list.set(i, str);
		}
		System.out.println("2. master_col_list : " + master_col_list.toString());
		String master_select_col = "";
		String[] temp;
		String[] temp2;
		
		//191107 에러 1.4 원인 부분
		for(int i=0; i<master_col_list.size(); i++) {
			if(i != master_col_list.size() -1) {
				System.out.println("master_col_list.get(i) : " + master_col_list.get(i));
				if(master_col_list.get(i).contains(" AS ")) {
					System.out.println(">> AS 포함 부분 처리");
					temp = master_col_list.get(i).split(" AS ");
					master_select_col += "a." + temp[1] + ", ";
				}else {
					//191107 에러 1.4 원인 수정 부분
					if(master_col_list.get(i).replaceFirst(" ", "").contains(".")) {
						System.out.println(">> AS 미포함  && . 포함 부분 처리");
						temp2 = master_col_list.get(i).replaceFirst(" ", "").split("\\.");
						System.out.println("master_col_list.get(i).replaceFirst(\" \", \"\")  : " + master_col_list.get(i).replaceFirst(" ", ""));
						master_select_col += "a." + temp2[1] + ", ";
					}else {
						System.out.println(">> AS 미포함  && . 미포함 부분 처리");
						master_select_col += "a." + master_col_list.get(i).replaceFirst(" ", "") + ", ";
					}
				}
			}else {
				if(master_col_list.get(i).contains(" AS ")) {
					System.out.println(">> AS 포함 부분 처리");
					temp = master_col_list.get(i).split(" AS ");
					master_select_col += "a." + temp[1];
				}else {
					//191107 에러 1.4 원인 수정 부분
					if(master_col_list.get(i).replaceFirst(" ", "").contains(".")) {
						System.out.println(">> AS 미포함  && . 포함 부분 처리");
						temp2 = master_col_list.get(i).replaceFirst(" ", "").split("\\.");
						master_select_col += "a." + temp2[1];
					}else {
						System.out.println(">> AS 미포함  && . 미포함 부분 처리");
						master_select_col += "a." + master_col_list.get(i).replaceFirst(" ", "");
					}
				}
			}
		}
		
		int slaveFromIndex = slave_sql.indexOf("FROM");
		String slave_select = slave_sql.substring(0, slaveFromIndex).replace("SELECT ", "");
		int slave_select_last_blank_index = slave_select.lastIndexOf(" ");
		slave_select = slave_select.substring(0, slave_select_last_blank_index);
		//slave_select = slave_select.replaceAll(" ", "");
		String[] slave_cols = slave_select.split(",");
		List<String> slave_col_list = Arrays.asList(slave_cols);
		//slave select문 컬럼들 앞에 공백 없애는 부분
		for(int i=0; i<slave_col_list.size(); i++){
			String str = slave_col_list.get(i).replaceFirst(" ", "");
			slave_col_list.set(i, str);
		}
		System.out.println("3. slave_col_list : " + slave_col_list.toString());
		String slave_select_col = "";
		String[] slave_temp;
		String[] slave_temp2;
		//191107 에러 1.4 원인 부분
		// case when 처리 하는 부분 없는 이유? case when 같은 경우 어차피 뒤에 as가 붙어 있기 때문에 as 부분 처리 하는 곳에서 걸러짐 
		for(int i=0; i<slave_col_list.size(); i++) {
			if(i != slave_col_list.size() -1) {
				System.out.println("slave_col_list.get(i) : " + slave_col_list.get(i));
				if(slave_col_list.get(i).contains(" AS ")) {
					System.out.println(">> AS 포함 부분 처리");
					slave_temp = slave_col_list.get(i).split(" AS ");
					if(master_col_list.contains(slave_temp[1])) {
						slave_select_col += "b." + slave_temp[1] + " AS " + slave_temp[1] + "_" + slave_key +", ";
					}else {
						slave_select_col += "b." + slave_temp[1] + ", ";
					}
				}else {
					//191107 에러 1.4 원인 수정 부분
					if(slave_col_list.get(i).replaceFirst(" ", "").contains(".")) {
						System.out.println(">> AS 미포함 & . 포함 부분 처리");
						slave_temp2 = slave_col_list.get(i).replaceFirst(" ", "").split(".");
						if(master_col_list.contains(slave_temp2[1])) {
							slave_select_col += "b." + slave_temp2[1] + " AS " + slave_temp2[1] + "_" + slave_key + ", ";
						}else {
							slave_select_col += "b." + slave_temp2[1] + ", ";
						}
					}else {
//						System.out.println(">> AS 미포함 & . 미포함 부분 처리");
//						slave_select_col += "b." + slave_col_list.get(i).replaceFirst(" ", "") + ", ";
						System.out.println(">> AS 미포함 & . 미포함 부분 처리");
//						//191107 에러 1.4 원인 수정 부분 : 2중 조인 안되는 부분 처리(조인 키들만 _1 붙도록 했음) => 중복 컬럼들 처리 하기 위해 잠시 막아둠
//						if(master_on_col.equals(slave_on_col) && slave_col_list.get(i).replaceAll(" ", "").equals(slave_on_col)) {
//							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + " AS " + slave_col_list.get(i).replaceAll(" ", "") + "_1" + ", ";
//						}else {
//							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + ", ";
//						}
						//191107 에러 1.4 원인 수정 2번째 보안
						if(master_col_list.contains(slave_col_list.get(i).replaceAll(" ", ""))) {
							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + " AS " + slave_col_list.get(i).replaceAll(" ", "") + "_" + slave_key + ", ";
						}else {
							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + ", ";
						}
					}
				}
			}else {
				if(slave_col_list.get(i).contains(" AS ")) {
					System.out.println(">> AS 포함 부분 처리");
					slave_temp = slave_col_list.get(i).split(" AS ");
					slave_select_col += "b." + slave_temp[1];
				}else {
					//191107 에러 1.4 원인 수정 부분
					if(slave_col_list.get(i).replaceFirst(" ", "").contains(".")) {
						System.out.println(">> AS 미포함 & . 포함 부분 처리");
						slave_temp2 = slave_col_list.get(i).replaceFirst(" ", "").split(".");
						if(master_col_list.contains(slave_temp2[1])) {
							slave_select_col += "b." + slave_temp2[1] + " AS " + slave_temp2[1] + "_" + slave_key;
						}else {
							slave_select_col += "b." + slave_temp2[1];
						}
					}else {
						System.out.println(">> AS 미포함 & . 미포함 부분 처리");
//						//191107 에러 1.4 원인 수정 부분 : 2중 조인 안되는 부분 처리(조인 키들만 _1 붙도록 했음) => 중복 컬럼들 처리 하기 위해 잠시 막아둠
//						if(master_on_col.equals(slave_on_col) && slave_col_list.get(i).replaceAll(" ", "").equals(slave_on_col)) {
//							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + " AS " + slave_col_list.get(i).replaceAll(" ", "") + "_1";
//						}else {
//							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "");
//						}
						//191107 에러 1.4 원인 수정 2번째 보안
						if(master_col_list.contains(slave_col_list.get(i).replaceAll(" ", ""))) {
							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "") + " AS " + slave_col_list.get(i).replaceAll(" ", "") + "_" + slave_key;
						}else {
							slave_select_col += "b." + slave_col_list.get(i).replaceAll(" ", "");
						}
					}
				}
			}
		}		
		
		String select_stmt = master_select_col + ", " + slave_select_col;
		System.out.println("4. select_stmt : " + select_stmt);
		
		
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
		//마지막에 붙은 공백 제거 및 제일 처음의 공백 제거
		child_sql_select = child_sql_select.substring(0, blank_index);
		//컬럼들 ,를 기준으로 각각 뽑아냄
		String[] child_sql_split = child_sql_select.split(",");
		List<String> child_sql_split_list = Arrays.asList(child_sql_split);
		for(int i=0; i<child_sql_split_list.size(); i++) {
			String str = child_sql_split_list.get(i).replaceFirst(" ", "");
			child_sql_split_list.set(i, str);
		}
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
		
		//자식 sql의 select절 컬럼 개수와 add된 테이블의 컬럼 개수가 다르면 보고자 하는 컬럼 개수가 다르다고 판단
		//자식 sql의 select절 컬럼에서 뺄놈들 빼는 부분
		if(child_sql_split_length != from_cols_length) {
			while(true) {
				System.out.println("child_sql_split_list.get(" + i + ") : " + child_sql_split_list.get(i) + " | "  + "from_cols_list.get(" + j + ") : " + from_cols_list.get(j));
				//자식 sql문의 select문 컬럼에  add된 테이블의 from 컬럼 이름이 포함 되어 있으면 자식 sql의 select문 컬럼을 추가
				if(child_sql_split_list.get(i).contains(from_cols_list.get(j))) {
					//add된 테이블의 from 컬럼의 전수 조사가 끝나면 while문 종료 
					if(j == to_cols.length-1) {
						//replaceFirst : 공백이 존재해서 공백 제거 할려고 붙임
						select_stmt += child_sql_split_list.get(i).replaceFirst(" ", "");
						System.out.println(">>> select_stmt : " + select_stmt);
						break;
					}else {
						select_stmt += child_sql_split_list.get(i).replaceFirst(" ", "") + ", ";
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
		
		//2019-11-07 rename -> addition -> rename처럼 연속적으로 할 경우 이상해짐 enpno as empno ad empno 이런식으로 변경됨.
		//변경 하고자 하는 컬럼명 적용 부분
//		String to_col = "";
//		String from_col = "";
//		String[] select_stmt_cols = select_stmt.split(",");
//		List<String> select_stmt_col_list = Arrays.asList(select_stmt_cols);
//		for(int s=0; s<to_cols_list.size(); s++) {
//			from_col = from_cols_list.get(s);
//			System.out.println("---------------------------------------");
//			System.out.println("from_col : " + from_col);
//			if(select_stmt_col_list.get(s).contains("CASE WHEN")) {
//
//			}else {
//				to_col = from_col + " AS " + to_cols_list.get(s);
//				select_stmt = select_stmt.replaceFirst(from_col, to_col);
//			}
//			System.out.println("to_col : " + to_col);
//			System.out.println("select_stmt : " + select_stmt);
//		}
		
		//add테이블의 to 컬럼 저장 변수
		String to_col = "";
		//add테이블의 from 컬럼 저장 변수
		String from_col = "";
		//자식 sql의 select문 컬럼에서 뺄놈 배고 남은 컬럼 저장 변수
		String child_select_col = "";
		//자식 sql의 select문 컬럼에서 뺄놈 배고 남은 컬럼 리스트들
		String[] select_stmt_cols = select_stmt.split(",");
		List<String> select_stmt_col_list = Arrays.asList(select_stmt_cols);
		for(int k=0; k<select_stmt_col_list.size(); k++) {
			String str = select_stmt_col_list.get(k).replaceFirst(" ", "");
			select_stmt_col_list.set(k, str);
		}
		//변수 재활용
		select_stmt = "";
		for(int s=0; s<select_stmt_col_list.size(); s++) {
			from_col = from_cols_list.get(s);
			to_col = to_cols_list.get(s);
			child_select_col = select_stmt_col_list.get(s);
			System.out.println("---------------------------------------");
			System.out.println("from_col : " + from_col);
			System.out.println("to_col : " + to_col);
			System.out.println("child_select_col : " + child_select_col);
			//이름을 변경하는 컬럼이 아니면 자식 컬럼명 사용
			if(from_col.equals(to_col)) {
				if(s == select_stmt_col_list.size()-1) {
					select_stmt += child_select_col;
				}else {
					select_stmt += child_select_col + ", ";
				}
			//이름을 변경하고자 하는 컬럼의 경우
			}else {
				//자식 select문의 컬럼에 AS를 포함하여 이미 별칭을 사용하고 있을 경우 AS 뒤의 내용만 바꾼다
				if(child_select_col.contains(" AS ")) {
					if(s == select_stmt_col_list.size()-1) {
						String[] split_array = child_select_col.split(" AS ");
						split_array[1] = to_col;
						select_stmt += split_array[0] + " AS " + split_array[1];
					}else { 
						String[] split_array = child_select_col.split(" AS ");
						split_array[1] = to_col;
						select_stmt += split_array[0] + " AS " + split_array[1] + ", ";
					}
				}else {
					if(s == select_stmt_col_list.size()-1) {
						select_stmt += child_select_col + " AS " + to_col;
					}else {
						select_stmt += child_select_col + " AS " + to_col + ", ";
					}
				}
			}
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
		//주석 풀어야되는 부분
		DAOforGetUserScemaNM dao = new DAOforGetUserScemaNM();
		ArrayList<String> list = dao.getUserSchemaList(user_id);
		System.out.println("---------------\n");
		//주석 해야되는 부분
//		ArrayList<String> list = null;
		
		return list;
	}

	@Override
	public String schemaLogin(String id, String pwd, HttpSession session) {
		// TODO Auto-generated method stub
		
		System.out.println("\n--- schemaLogin.java ---");
		System.out.println("1. Schema ID : " + id);
		System.out.println("2. Schema PWD : " + pwd);
		DAO dao = new DAO(session);
		String user_sch_nm = dao.schemaLogin(id, pwd);
		System.out.println("3. LoginSuccess : " + user_sch_nm);
		System.out.println("---------------\n");
		if(user_sch_nm.equals("")){
			user_sch_nm = null;
		}else {
			session.setAttribute("schemaid", id);
			session.setAttribute("schemapwd", pwd);
		}
		
		return user_sch_nm;
	}


}
