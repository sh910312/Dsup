var Process = (function() {
	// instance stores a reference to the Singleton
	var instance;
	var request;

	function createInstance() {
		// private variables and methods
		var result;

		return {
			getData : function(momo, info) {
				// var settingInfo = momo.getSettingInfo();
				console.log("[process] : " + info);
				switch (momo.getType()) {
				case "DBread":
					var sql = $('#sql-statement').val();
					$('#sql-statement').html(sql);
					// var sql = settingInfo["STATEMENT"];
					momo.setTag($('#dbread-setting-bar').html());
					request.open("Post", "DBread.do?sql=" + sql, false);

					request.onreadystatechange = function() {
						if (request.readyState == 4 && request.status == 200) {
							result = request.responseText;
							// console.log("result : " + result);
						}
					};

					request.send(null);
					return result;

					break;

				case "Filter":
					// var sql = $('#sql-statement').val();
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
					request.open("Post", "Filter.do?sql=" + child_sql
							+ "&expression=" + expression, false);

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
					var join_expression = $('#join-expression').text(); // empno=empno
					var join_type = $('input[name=joinType]').val(); // innerLeft
					// console.log("[Join Expression] : " + join_expression + "
					// | " + "[Join Type] : " + join_type);
					// var setting_map = new Map();
					// var sql_map = new Map();
					var sql_1;
					var sql_2;
					var join_key_1;
					var join_key_2;

					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var val = $('#' + key).find('tr.clicked')
									.children().eq(0).text();
							if (i == 0) {
								join_key_1 = val;
							} else {
								join_key_2 = val;
							}
							// setting_map[key] = val;
						}
					}

					for (var i = 0; i < info.length; i++) {
						var json = JSON.parse(info[i]);
						for ( var key in json) {
							var a_json = json[key];
							for ( var a_key in a_json) {
								if (a_key == "SQL") {
									if (i == 0) {
										sql_1 = a_json[a_key];
									} else {
										sql_2 = a_json[a_key];
									}
									// sql_map[key] = a_json[a_key];
								}
							}
						}
					}

					request.open("Post",
							"Join.do?sql_1=" + encodeURI(sql_1) + "&sql_2="
									+ encodeURI(sql_2) + "&join_key_1="
									+ encodeURI(join_key_1) + "&join_key_2="
									+ encodeURI(join_key_2) + "&join_type="
									+ join_type, false);

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
					var child_sql;
					var colName = $("#add-col-expression-table tr").eq(1)
							.children().eq(0).text();
					var expression = $("#add-col-expression-table tr").eq(1)
							.children().eq(1).text();

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

					request.open("Post", "Addition.do?sql="
							+ encodeURI(child_sql) + "&colName="
							+ encodeURI(colName) + "&expression="
							+ encodeURI(expression), false);

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
					var map = {};
					var child_sql;
					var tr_list_length = $('#sort-order-table tr').length;
					for (var i = 1; i < tr_list_length; i++) {
						var key = $('#sort-order-table tr').eq(i).children()
								.eq(0).text();
						var val = $('#sort-order-table tr').eq(i).children()
								.eq(1).find("option:selected").val();
						map[key] = val;
					}
					var param = JSON.stringify(map);

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
					var union_type = $("#union-type-select").find(':selected')
							.val();
					var master = $('p:contains(Master)').parent().next().text();
					var slave = $('p:contains(Slave)').parent().next().text();
					var master_table_length = $('#union_' + master).children().length;
					var matching_table_length = $('#union-match-table')
							.children().length - 1;
					var master_sql;
					var slaver_sql;
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
						var err_msg = "";
						err_mag = "[Union Apply Error] 컬럼을 모두 매칭 해주십시오.";
						$("#state_msg_div")
								.append("<div>" + err_msg + "</div>");
					}

				case 'Rename':
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
						for(var i=1; i<to_table_length; i++){
							var from_col = $('#rename-add-table tr').eq(i).children().eq(0).text();
							var to_col = $('#rename-add-table tr').eq(i).children().eq(1).text();
							if(i != to_table_length-1){
								select = select + from_col + " AS " + to_col + ", ";
							}else{
								select = select + from_col + " AS " + to_col;
							}
						}
						
						var sql = "SELECT " + select + " " +
						          from_where;					

						request.open("Post", "Rename.do?param=" + encodeURI(sql), false);

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
						err_msg = common.getToDay() + " [Rename Error] <From Columns>에서 체크한 column들을 Add 하여주십시오.";
						$("#state_msg_div").append("<div>" + err_msg + "</div>");
					}
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
