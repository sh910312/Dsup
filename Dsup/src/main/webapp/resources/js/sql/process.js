var Process = (function() {
	// instance stores a reference to the Singleton
	var instance;
	var request;
	
    String.prototype.replaceAt=function(index, character) {
        return this.substr(0, index) + character + this.substr(index+character.length);
    }
	
	function createInstance() {
		// private variables and methods

		return {
			getData : function(momo, info) {
				// var settingInfo = momo.getSettingInfo();
				var result;
				//console.log("[process] : " + info);
				switch (momo.getType()) {
				case "DBread":
					var sql = $('#sql-statement').val();
					if(sql != null || sql != ""){
						$('#sql-statement').html(sql);
						// var sql = settingInfo["STATEMENT"];
						momo.setTag($('#dbread-setting-bar').html());
						request.open("GET", "DBread.do?sql=" + encodeURI(sql), false);
						
						request.onreadystatechange = function() {
							if (request.readyState == 4 && request.status == 200) {
								result = request.responseText;
								console.log("DBread Result : " + result);
							}
						};
						
						request.send(null);
						return result;
					}else{
						var err_msg = "[DBread Error] sql문을 입력해주십시오.";
						common.errorMessage(err_msg);
					}

					break;

				case "Filter":
					// var sql = $('#sql-statement').val();
					var result;

					var child_sql = info["SQL"];
					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var a_json = json[key];
							for ( var a_key in a_json) {
								if (a_key == "SQL") {
									child_sql = a_json[a_key];
									break;
								}
							}
						}
					}
					var expression = $('#fiter-expression').val();
					$('#fiter-expression').html(expression);
					request.open("Post", "Filter.do?sql=" + encodeURI(child_sql)
							+ "&expression=" + encodeURI(expression), false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							// console.log("result : " + result);

						}
					};

					request.send(null);
					momo.setTag($('#filter-setting-bar').html());
					return result;

					break;

				case 'Join':
					var result;
					var join_expression = $('#join-expression').text(); // empno=empno
					var join_type = $('input[name=joinType]').val(); // innerLeft
					
					var master_sql;
					var slave_sql;
					var list = [];
					var join_key_1;
					var join_key_2;
					var join_cnt=$('#join-expression li').length;
					
					for(var i=0; i<join_cnt; i++){
						var map = {};
						var master = $('.table_1_clicked_col').eq(i).text();
						var slave = $('.table_2_clicked_col').eq(i).text();
						map["master"] = master;
						map["slave"] = slave;
						list.push(map);
					}
					
					var join_key = JSON.stringify({join_key:list});
					var maset_key = "";
					var slave_key = "";
					//자식 sql 가지고 오는 부분
					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var a_json = json[key];
							for ( var a_key in a_json) {
								if (a_key == "SQL") {
									if (i == 0) {
										maset_key = key;
										master_sql = a_json[a_key];
									} else {
										slave_key = key;
										slave_sql = a_json[a_key];
									}
									// sql_map[key] = a_json[a_key];
								}
							}
						}
					}

					request.open("Post",
							"Join.do?master_sql=" + encodeURI(master_sql) + 
							"&slave_sql=" + encodeURI(slave_sql) +
							"&join_key=" + encodeURI(join_key) + 
							"&join_type=" + encodeURI(join_type) +
							"&maset_key=" + encodeURI(maset_key) +
							"&slave_key=" + encodeURI(slave_key), false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							console.log("[join process result] : " + result);

						}
					};

					request.send(null);
					var setting_info = $('#join-setting-bar').html();
					console.log(setting_info);

					momo.setTag(setting_info);

					return result;

					break;

				case "Addition":
					var result;
					var child_sql;
					var colName = "";
					var expression = "";
					var expression_list = [];
					var expression_tb_length = $("#add-col-expression-table tr").length;
					for(var j=1; j<expression_tb_length-1; j++){
						var map = {};
						colName = $("#add-col-expression-table tr").eq(j).children().eq(0).text();
						expression = $("#add-col-expression-table tr").eq(j).children().eq(1).text();
						map["colName"] = colName;
						map["expression"] = expression;
						expression_list.push(map);
					}
					var param = JSON.stringify({param:expression_list});
					
					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var a_json = json[key];
							for ( var a_key in a_json) {
								if (a_key == "SQL") {
									child_sql = a_json[a_key];

									break;
								}
							}
						}
					}

					request.open("Post", "Addition.do?sql=" + encodeURI(child_sql) + 
							"&param=" + encodeURI(param), false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							console
									.log("[Addition process result] : "
											+ result);

						}
					};

					request.send(null);
					var setting_info = $('#addition-setting-bar').html();

					momo.setTag(setting_info);

					return result;

					break;

				case 'Order':
					var result;
					var list = [];
					var child_sql;
					//var temp = {};
					var tr_list_length = $('#sort-order-table tr').length;
					for (var i = 1; i < tr_list_length; i++) {
						var map = {};
						var key = $('#sort-order-table tr').eq(i).children()
								.eq(0).text();
						var val = $('#sort-order-table tr').eq(i).children()
								.eq(1).find("option:selected").val();
						map["key"] = key;
						map["value"] = val;
						list.push(map);
					}
					var param = JSON.stringify({param:list});

					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var a_json = json[key];
							for ( var a_key in a_json) {
								if (a_key == "SQL") {
									child_sql = a_json[a_key];

									break;
								}
							}
						}
					}

					request.open("Post", "Order.do?param=" + encodeURI(param)
							+ "&child_sql=" + encodeURI(child_sql), false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							console.log("[Order process result] : " + result);

						}
					};

					request.send(null);

					var setting_info = $('#order-setting-bar').html();
					console.log(setting_info);

					momo.setTag(setting_info);

					return result;

				case 'Union':
					var result;
					var union_type = $("#union-type-select").find(':selected')
							.val();
					var master = $('p:contains(Master)').parent().next().text();
					var slave = $('p:contains(Slave)').parent().next().text();
					//마스터 테이블의 열 갯수가 모두 매칭 테이블에 add 됐는지 판단하기 위해 각각 테이블의 열개수를 구함
					var master_table_length = $('#union_' + master + ' tr').length-1;
					var matching_table_length = $('#union-match-table').children().length - 1;
					var master_sql;
					var slaver_sql;
					//마스터 테이블의 모든 컬럼이 매칭 되어야만 실행
					if (master_table_length == matching_table_length) {
						for (var i = 0; i < info.length; i++) {
							var json = JSON.parse(info[i]);
							for ( var key in json) {
								var a_json = json[key];
								for ( var a_key in a_json) {
									if (a_key == "SQL") {
										if (key == master) {
											master_sql = a_json[a_key];
										} else {
											slaver_sql = a_json[a_key];
										}
									}
								}
							}
						}

						request.open("Post", "Union.do?master_sql="
								+ encodeURI(master_sql) + "&slaver_sql="
								+ encodeURI(slaver_sql) + "&union_type="
								+ encodeURI(union_type), false);

						request.onreadystatechange = function() {
							if (request.readyState == 4
									&& request.status == 200) {
								result = request.responseText;
								console.log("[Union process result] : "
										+ result);

							}
						};

						request.send(null);
						var setting_info = $('#union-setting-bar').html();
						console.log(setting_info);

						momo.setTag(setting_info);

						return result;

						break;
					} else {
						var err_msg = "[Union Apply Error] 컬럼을 모두 매칭 해주십시오.";
						common.errorMessage(err_msg);
					}
					
					break;
				case 'Rename':
					var result;
					var from_table_check_cnt = $('#rename-table').find('input:checked').length;
					var to_table_col_cnt = $('#rename-add-table tr').length-1;
					
					if(from_table_check_cnt == to_table_col_cnt){
						var child_sql;
						for (var i = 0; i < info.length; i++) {
							var json = JSON.parse(info[i]);
							for ( var key in json) {
								var a_json = json[key];
								for ( var a_key in a_json) {
									if (a_key == "SQL") {
										child_sql = a_json[a_key].toUpperCase();

										break;
									}
								}
							}
						}
						
						var from_index = child_sql.indexOf("FROM");
						var where_index = child_sql.lastIndexOf("WHERE");
						// ex) select EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO FROM emp WHERE deptno=10
						//var select = child_sql.substring("SELECT ".length, from_index); // EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
						var from_where = child_sql.substring(from_index, child_sql.length); //FROM emp WHERE deptno=10
						//var from = child_sql.substring(from_index+"FROM ".length, where_index); // emp
						//var where = child_sql.substring(where_index+"WHERE ".length, child_sql.length); // deptno=10

						var to_table_length = $('#rename-add-table tr').length;
						var select = "";
						var to_cols = "";
						var from_cols = "";
						for(var i=1; i<to_table_length; i++){
							var from_col = $('#rename-add-table tr').eq(i).children().eq(0).text();
							var to_col = $('#rename-add-table tr').eq(i).children().eq(1).text();
							if(i != to_table_length-1){
								select = select + from_col + " AS " + to_col + ", ";
								to_cols += to_col + ", ";
								from_cols += from_col + ", ";
							}else{
								select = select + from_col + " AS " + to_col;
								to_cols += to_col;
								from_cols += from_col;
							}
						}
						
						var sql = "SELECT " + select + " " +
						          from_where;					

						request.open("Post", "Rename.do?from_cols=" + encodeURI(from_cols) +
								     "&to_cols=" + encodeURI(to_cols) +
								     "&child_sql=" + encodeURI(child_sql), false);

						request.onreadystatechange = function() {
							if (request.readyState == 4 && request.status == 200) {
								result = request.responseText;
								console.log("[Rename process result] : " + result);

							}
						};

						request.send(null);

						var setting_info = $('#rename-setting-bar').html();
						console.log(setting_info);

						momo.setTag(setting_info);

						return result;
					}else{
						var err_msg = "[Rename Error] <From Columns>에서 체크한 column들을 Add 하여주십시오.";
						common.errorMessage(err_msg);
					}
				}
			},
			getDBinsertTargetTableList : function(){
				console.log("[getDBinsertTargetTableList]");
				var result = "";
				request.open("Post", "TargetTableList.do", false);

				request.onreadystatechange = function() {
					if (request.readyState == 4 && request.status == 200) {
						result = request.responseText;
						console.log("result : " + result);
					}
				};
				request.send(null);
				//schema에 따라 보유한 테이블 list
				return result;
			},
			getTargetTableInfo : function(){
				console.log("[getTargetTableInfo]");
				var targetTable = $('#target_table_list option:selected').val();
				var result = "";
				request.open("Post", "TargetTableInfo.do?targetTable=" + encodeURI(targetTable), false);

				request.onreadystatechange = function() {
					if (request.readyState == 4 && request.status == 200) {
						result = request.responseText;
						console.log("result : " + result);
					}
				};
				request.send(null);
				//schema에 따라 보유한 테이블 list
				return result;
			},
			dbInsert : function(info){
				var execution_mode = $('#dbinsert-mode option:selected').val();
				//$('#dbinsert-execution-table tr').eq(1).children().eq(0).text();
				var result = "";
				var child_sql = "";
				var target_table = $('#target_table_list option:selected').val();
				
				for (var i = 0; i < info.length; i++) {
					var json = JSON.parse(info[i]);
					for ( var key in json) {
						var a_json = json[key];
						for ( var a_key in a_json) {
							if (a_key == "SQL") {
								child_sql = a_json[a_key];
								
								break;
							}
						}
					}
				}

				
				if(execution_mode == "Insert"){
					//매칭컬럼들 가지고 오는 부분
					var for_length = $('#dbinsert-execution-table tr td.target_col').length;
					var target_cols = "";
					var input_cols = "";
					for(var i=0; i<for_length; i++){
						var target_col = $('#dbinsert-execution-table tr td.target_col').eq(i).text();
						var input_col = $('#dbinsert-execution-table tr td.input_col').eq(i).text();
						if(i == for_length-1){
							target_cols += target_col;
							input_cols += input_col;
						}else{
							target_cols += target_col + ", ";						 
							input_cols += input_col + ", ";
						}
					}
					
					var sql = "INSERT INTO " + target_table + "(" + target_cols + ") " + child_sql;

					request.open("Post", "DBinsert.do?sql=" + encodeURI(sql) + 
							"&target_table=" + encodeURI(target_table), false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							console.log("[result] DB insert Success");
						}
					};
					request.send(null);
					
				}else if(execution_mode == 'Update'){
					//sal<1000 and deptno<=20
					//$('#dbinsert-execution-table tr td.target_col').eq(0).text()
					var where_stmt = "";
					var where_stmt_cnt = $('#dbinsert-whereStmt-table select').length/2;
					for(var i=0; i<where_stmt_cnt; i++){
						var target_col = $('#where-stmt-target-select option:selected').text();
						var input_col = $('#where-stmt-input-select option:selected').text();
						if(i == where_stmt_cnt-1){
							where_stmt += "a." + target_col + "=b." + input_col;
						}else{
							where_stmt += "a." + target_col + "=b." + input_col + ", ";
						}
					}
					
					var set_stmt = "";
					var select_stmt = "";
					var from_index = child_sql.indexOf('FROM');
					//Target Table에서 add된 컬럼들의 길이 가져옴 
					var match_table_length = $('#dbinsert-target-table tr[class*="added"]').length;
					//child sql에서 select 컬럼들만 가져오는 부분
					var child_sql_select = child_sql.substring(0, from_index).replace("SELECT ", "");
					
					for(var i=0; i<match_table_length; i++){
						var target_col = $('#dbinsert-target-table tr[class*="added"]').eq(i).children().eq(1).text();
						var input_col = $('#dbinsert-target-table tr[class*="added"]').eq(i).children().eq(3).text();
						if(i == match_table_length-1){
							set_stmt += target_col;
							select_stmt += input_col;
						}else{
							set_stmt += target_col + ', ';
							select_stmt += input_col + ', ';
						}
					}
					
					//매칭컬럼들 가지고 오는 부분
					var for_length = $('#dbinsert-execution-table tr td.target_col').length;
					var target_cols = "";
					var input_cols = "";
					var update_set_stmt = "";
					for(var i=0; i<for_length; i++){
						var target_col = $('#dbinsert-execution-table tr td.target_col').eq(i).text();
						var input_col = $('#dbinsert-execution-table tr td.input_col').eq(i).text();
						if(i == for_length-1){
							target_cols += "a." + target_col;
							input_cols += "b." + input_col;
							var temp_update_set_stmt = "a." + target_col + "=" + "b." + input_col;
							console.log("[where구문 update구문 비교하는 부분] where_stmt : " + where_stmt + " | " + "temp_update_set_stmt : " + temp_update_set_stmt);
							if(where_stmt != temp_update_set_stmt){
								update_set_stmt += "a." + target_col + "=" + "b." + input_col;
							}

						}else{
							target_cols += "a." + target_col + ", ";						 
							input_cols += "b." + input_col + ", ";
							var temp_update_set_stmt = "a." + target_col + "=" + "b." + input_col;
							console.log("[where구문 update구문 비교하는 부분] where_stmt : " + where_stmt + " | " + "temp_update_set_stmt : " + temp_update_set_stmt);
							if(where_stmt != temp_update_set_stmt){
								update_set_stmt += "a." + target_col + "=" + "b." + input_col + ", ";
							}
						}
					}
					var sql = "";
					if(where_stmt != null || where_stmt != ""){
//						var sql = "UPDATE " + target_table + " a SET (" + set_stmt + ") =" +
//				          "(SELECT b." + select_stmt + " " +
//				           "FROM (" + child_sql + ") b " + 
//				           "WHERE " + where_stmt + ") ";
						//Merge Update 해야되는 부분
						sql = "MERGE INTO " + target_table + " a " +
										    "USING (" + child_sql + ") b " + 
										    "  ON (" + where_stmt + ") " +
										    "WHEN MATCHED THEN " +
										    "    UPDATE SET " + update_set_stmt + " " +
										    "WHEN NOT MATCHED THEN " +
										    "    INSERT (" + target_cols + ")" + 
										    "    VALUES (" + input_cols + ")";
					}else{
						sql = "UPDATE " + target_table + " " +
				          "SET (" + target_cols + ")=" +
				          "(SELECT " + input_cols + " " +
				           "FROM (" + child_sql + "))";
					}
					
					console.log("[Update SQL] " + sql);
					
					request.open("Post", "DBupdate.do?sql=" + encodeURI(sql) +
							"&target_table=" + target_table, false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							console.log("[result] DB insert Success");
						}
					};
					
					request.send(null);
					
				}else if(execution_mode == 'merge'){
					
				}
			}
		};
	}

	return {
		// Get the Singleton instance if it exists
		// or create one if doesn't
		getInstance : function() {
			if (!instance) {
				request = new XMLHttpRequest();
				instance = createInstance();
			}
			return instance;
		}
	};
})();
