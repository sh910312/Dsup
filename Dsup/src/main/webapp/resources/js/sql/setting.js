var Setting = (function() {
	// instance stores a reference to the Singleton
	var instance;

	function createInstance() {
		// private variables and methods
		var dbReadTag = $('#dbread-setting-bar').html();
		var filterTag = $('#filter-setting-bar').html();
		var joinTag = $('#join-setting-bar').html();
		var additionTag = $('#addition-setting-bar').html();
		var orderTag = $('order-setting-bar').html();
		var unionTag = $('union-setting-bar').html();
		var renameTag = $('rename-setting-bar').html();

		function click(obj) {
			var tbody = obj.parentNode;
			var trs = tbody.getElementsByTagName('tr');
			var orgBColor = '#ffffff';
			var toBColor = "#c0c0c0";

			for (var i = 0; i < trs.length; i++) {
				if (trs[i] != obj) {
					if (trs[i].className != "Manual_added"
							&& trs[i].className != "Auto_added"
							&& trs[i].className != "added") {
						trs[i].style.backgroundColor = orgBColor;
						$(trs[i]).removeAttr('class');
					}
				} else {
					if (trs[i].className != "Manual_added"
							&& trs[i].className != "Auto_added"
							&& trs[i].className != "added") {
						trs[i].style.backgroundColor = toBColor;
						$(trs[i]).attr('class', 'clicked');
					}
				}
			}
		}

		function unionManualAdd(add_type, t) {
			var master = $('#union-master-select').find('option:selected')
					.val();
			var slave = $('.union-dataTableName').eq(0).text();
			if (master == slave) {
				slave = $('.union-dataTableName').eq(1).text();
			}
			var master_col = $('#union_' + master + ' tr.clicked td').eq(0)
					.text();
			var master_type = $('#union_' + master + ' tr.clicked td').eq(1)
					.text();
			var slave_col = $('#union_' + slave + ' tr.clicked td').eq(0)
					.text();
			var slave_type = $('#union_' + slave + ' tr.clicked td').eq(1)
					.text();
			var tag = "";
			tag += "<tr><td>" + master_col + "</td>" + "<td>" + slave_col
					+ "</td>" + "<td>" + master_type + "</td></tr>";
			$("#union-match-table").append(tag);
			// 추가된 열의 상태값 변경
			changeTrClassName(add_type, t);
		}

		function changeTrClassName(add_type, t) {
			var toBColor = "#f5f5dc";
			var table = $('#' + t.toLowerCase() + '-contents-container table');
			var table_length = table.length;
			for (var i = 0; i < table_length; i++) {
				var tr = table.eq(i).find('tr.clicked');
				// add된 행의 색갈 바꿈
				tr.css("background-color", "#f5f5dc");
				// add된 행의 class이름 added로 변경 함으로 추가됨을 열임을 판단
				if (add_type == "") {
					tr.attr('class', 'added');
				} else {
					tr.attr('class', add_type + '_added');
				}
			}
		}

		function makeChildInfoTableTag(info) {
			// console.log("info : " + info);
			// var json = JSON.parse(info);
			// console.log(json);
			var tag = "";
			var result = new Map();
			for (var i = 0; i < info.length; i++) {
				var json = JSON.parse(info[i]);
				for ( var childKey in json) {
					var a_json = json[childKey];
					for ( var a_key in a_json) {
						if (a_key == "COL_NM_TYPE") {
							var b_json = a_json[a_key];
							for (b_key in b_json) {
								tag = tag + '<tr>' + '<td>' + b_key + '</td>'
										+ '<td>' + b_json[b_key] + '</td>'
										+ '</tr>';
							}
							// result.set(childKey, tag);
							result[childKey] = tag
						}
					}
				}
				tag = "";
			}

			return result;
		}
		
		function renewalToChildInfoTableTag(){
			var checked_col_length = $('#rename-table tr td input:checked').length;
			
			var tag = "<tr><th>From</th><th>To</th></tr>";
			
			for (var i = 0; i < checked_col_length; i++) {
				var from_col = $('#rename-table tr td input:checked').eq(i).parent().siblings().eq(0).text().toUpperCase();
				var to_col = $('#rename-table tr td input:checked').eq(i).parent().siblings().eq(2).children().val().toUpperCase();
				if(to_col == ""){
					to_col = from_col;
				}
				//var checked_col_index = $('#rename-table tr').index($('#rename-table tr td input:checked').eq(i).parent().parent())
				tag = tag + '<tr>' + '<td>' + from_col + '</td>'
				+ '<td>' + to_col + '</td>'
				+ '</tr>';
			}
			
			return tag;
		}
		
		function renewalFromChildInfoTableTag(info) {
			var tag = "";
			var result = new Map();
			for (var i = 0; i < info.length; i++) {
				var json = JSON.parse(info[i]);
				for ( var childKey in json) {
					var a_json = json[childKey];
					for ( var a_key in a_json) {
						if (a_key == "COL_NM_TYPE") {
							var b_json = a_json[a_key];
							for (b_key in b_json) {
								tag = tag + 
									'<tr>' +
										'<td>' + '<input type="checkbox" name="renewal-col-checkbox" value="' + b_key + '" checked onclick="controller.selectChanged(this);"/>' + '</td>' +
						 				'<td>' + b_key + '</td>' + 
						 				'<td>' + b_json[b_key] + '</td>' + 
						 				'<td><input type="text" class="addition-renwal-name" name="addition-renwal-name" style="border:none"/></td>'
						 			'</tr>';
							}
							// result.set(childKey, tag);
							result[childKey] = tag
						}
					}
				}
				tag = "";
			}

			return result;
		}

		return {
			// public methods and variables
			setDbReadTag : function(tag) {
				dbReadTag = tag;
			},
			getDbReadTag : function() {
				return dbReadTag;
			},
			getJoinTag : function() {
				return joinTag;
			},
			getFilterTag : function() {
				return filterTag;
			},
			open : function(key, type) {
				switch (type) {
				case 'DBread':
					console.log("DBread On");
					$('#dbread-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});

					break;
				// 동영
				case 'Filter':
					console.log("filter on");
					$('#filter-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;
				case 'Join':
					$('#join-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;

				case 'Addition':
					$('#addition-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;
				case 'Order':
					$('#order-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;
				case 'Union':
					$('#union-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;
				case 'Rename':
					$('#rename-setting-bar').css({
						'display' : 'block',
						'width' : '50%'
					});
					break;
				
				}
				

				$('#textarea-container').css({
					'display' : 'block',
					'width' : '40%'
				});
			},
			close : function(key, type) {
				switch (type) {
				case 'DBread':
					console.log("DBread Off");
					$('#dbread-setting-bar').css({
						'display' : 'none',
						'width' : '50%'
					});
					break;

				case "Filter":
					console.log("Filter off");
					$('#filter-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});

					break;

				case 'Join':
					console.log("Join off");
					$('#join-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});
					break;
				case 'Addition':
					console.log("Addition off");
					$('#addition-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});
					break;
				case 'Order':
					console.log("Order off");
					$('#order-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});
					break;
				case 'Union':
					console.log("Union off");
					$('#union-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});
					break;
				case 'Rename':
					console.log("Rename off");
					$('#rename-setting-bar').css({
						'display' : 'none',
						'width' : '19%'
					});
					break;
				}
			},
			clean : function(t) {
				switch (t) {
				case 'DBread':
					console.log("DBread clean()");

					$('#dbread-setting-bar').html(dbReadTag);

					break;

				case 'Filer':
					console.log("Filer clean()");

					$('#filer-setting-bar').html(filterTag);
					break;

				case 'Join':
					console.log("Join clean()");

					$('#join-setting-bar').html(joinTag);
					break;
				case 'Addition':
					console.log("Addition clean()");

					$('#addition-setting-bar').html(additionTag);
					break;
				case 'Order':
					console.log("Order clean()");

					$('#order-setting-bar').html(orderTag);
					break;
				case 'Union':
					console.log("Union clean()");

					$('#union-setting-bar').html(unionTag);
					break;
				case 'Rename' :
					console.log("Rename clean()");
					
					$('#rename-setting-bar').html(unionTag);
					break;
				}
			},
			decorate : function(k, t, info, n) {
				// console.log(k);
				switch (t) {
				case "DBread":
					if (n == "new") {
						$('#dbread-name').html(t);
						$('#dbread-key').html(k);
					} else {
						// var json = JSON.parse(info);
						// for(var key in json){
						// }
						$('#dbread-setting-bar').html(info);
					}
					break;

				case "Filter":
					if (n == "new") {
						var tags = makeChildInfoTableTag(info);

						for (key in tags) {
							$('#filter-table-list').html(tags[key]);
						}

						$('#filter-type').html(t);
						$('#filter-key').html(k);
					} else {
						// var json = JSON.parse(info);
						// for(var key in json){
						// }
						$('#filter-setting-bar').html(info);
					}

					break;

				case "Join":
					if (n == "new") {
						var tags = makeChildInfoTableTag(info);
						var i = 1;

						$('#join-momo-type').html(t);
						$('#join-momo-key').html(k);
						for (key in tags) {
							$('#join-dataTableName-' + i).html(key);
							$('#join-dataTable-' + i).html(tags[key]);
							$('#join-dataTable-' + i).attr('id', "join_" + key);
							i += 1;
						}
					} else {
						$('#join-setting-bar').html(info);
					}
					break;

				case "Addition":
					if (n == "new") {
						var add_tags = makeChildInfoTableTag(info);
						var renewal_tags = renewalChildInfoTableTag(info);

						$('#addition-name').html(t);
						$('#addition-key').html(k);

						for (var key in add_tags) {
							$('#additon-table').html(add_tags[key]);
						}
						
						for (var key in renewal_tags) {
							$('#additon-renewal-table').html(renewal_tags[key]);
						}
					} else {
						$('#addition-setting-bar').html(info);
					}

					break;

				case "Order":
					if (n == "new") {
						var tags = makeChildInfoTableTag(info);

						$('#order-name').html(t);
						$('#order-key').html(k);

						for (key in tags) {
							$('#order-table').html(tags[key]);
						}
					} else {
						$('#order-setting-bar').html(info);
					}

					break;
				case "Union":
					if (n == "new") {
						var tags = makeChildInfoTableTag(info);
						var i = 1;
						$('#union-momo-type').html(t);
						$('#union-momo-key').html(k);
						for (key in tags) {
							$('#union-dataTableName-' + i).html(key);
							if (i == 1) {
								var select_tag = "<option value='" + key
										+ "' selected='selected'>" + key
										+ "</option>"
							} else {
								var select_tag = "<option value='" + key + "'>"
										+ key + "</option>"
							}
							$('#union-master-select').append(select_tag);
							$('#union-dataTable-' + i).html(tags[key]);
							$('#union-master-mark-div-' + i).attr('id',
									'union-master-mark-' + key);
							$('#union-dataTable-' + i).attr('id',
									"union_" + key);
							i += 1;
						}
					} else {
						$('#union-setting-bar').html(info);
					}

					break;
				case 'Rename' :
					if(n == "new"){
						$('#rename-name').html(t);
						$('#rename-key').html(k);
						var from_tags = renewalFromChildInfoTableTag(info);
						
						for (key in from_tags) {
							$('#rename-table').append(from_tags[key]);
						}
						
						var to_tags = renewalToChildInfoTableTag();

						$('#rename-add-table').html(to_tags);
					}else{
						$('#rename-setting-bar').html(info);
					}
				}
			},
			tableClick : function(obj) {
				if ($(obj).parent().attr('id') != 'additon-table') {
					click(obj);
				}else{
					click(obj);
					var type = $('#additon-table tr.clicked td').eq(1).text();
					$('#additon-operaters-div .selected-col-type').html(type);
					$('#additon-operaters-div').css("display", "block");
				}
				
			},
			tableDoubleClick : function(obj) {
				if($(obj).parent().attr('id') != "additon-operaters-div"){
					var td_text = $(obj).children().eq(0).text();
					$('#addition-col-name').val(td_text);
					click(obj);
				}else if($(obj).parent().attr('id') == "additon-operaters-div"){
					var col = $('#additon-table tr.clicked td').eq(0).text();
					var operater = $(obj).text();
					var split_temp = operater.split('(');
					operater = split_temp[0];
					var expression = operater + "(" + col + ")";
					$('#addition-expression').val(expression);
				}
			},
			selectChanged : function(obj) {
				// $('#union-dataTable-' + i).attr('id', 'union_master_mark_' +
				// key);
				var change_type = $(obj).attr('name');
				
				if(change_type == 'additionType'){
//					var addition_type = $(obj).val();
//					var add_div_id = 'addition-add-col-conainer';
//					var renewa_div_id = 'addition-renewal-col-conainer';
//					
//					if(addition_type == 'add-col'){
//						$('#'+add_div_id).css('display', 'block');
//						$('#'+renewa_div_id).css('display', 'none');
//					}else{
//						$('#'+add_div_id).css('display', 'none');
//						$('#'+renewa_div_id).css('display', 'block');
//					}
				}else if(change_type == 'renewal-col-checkbox'){
					if($(obj).is(':checked')){
						$(obj).parent().siblings().children().attr('disabled', false);
						$(obj).parents('tr').css('background-color', 'white');
						//$(obj).prop('checked', true);
						$(obj).attr("checked", 'checked');
					}else{
						$(obj).parent().siblings().children().attr('disabled', true);
						$(obj).parents('tr').css('background-color', '#ebebe4');
						$(obj).removeAttr("checked")
						//$(obj).prop('checked', false);
					}
				}else if(change_type == 'order_type'){
					var sel = $(obj).val();
					$(obj.children).removeAttr('selected');
					$(obj.children).each(function(){
						if($(this).val() == sel){
							$(this).attr('selected', 'selected');
						}
					})
				}else{
					var master = $(obj).find("option:selected").text();
					var slave;
					var select_leng = $(obj).children().length;
					
					for (var i = 0; i < select_leng; i++) {
						if ($(obj).children().eq(i).text() != master) {
							slave = $(obj).children().eq(i).text();
						}
					}
					
					$('#union-master-mark-' + master).html("<p>Master</p>");
					$('#union-master-mark-' + slave).html("<p>Slave</p>");
				}
				
				console.log("changed");
			},
			getSettingInfo : function(t) {
				var map = new Map();
				var array = new Array();

				switch (t) {
				case "DBread":
					var sqlStatement = $('#sql-statement').val();
					// sqlStatement = sqlStatement.replace(/\r\n/g, "");//엔터제거
					// sqlStatement = sqlStatement.replace("\u21b5", "");
					// console.log(sqlStatement);
					map["STATEMENT"] = sqlStatement
					// map.set("DBread", sqlStatement);
					return map;

					break;
				case "Fiter":
					var expression = $('#fiter-expression').val();
					map["EXPRESSION"] = expression;

					return map;
				}
			},
			join : function() {

			},
			add : function(t) {

				switch (t) {
				case 'Join' :
					var joinType = $(":input:radio[name=joinType]:checked").val();
					var table_1 = $('#join-dataTableName-1').text();
					var table_2 = $('#join-dataTableName-2').text();
					var table_1_clicked_col = $('#join_' + table_1 + ' tr.clicked td').eq(0).text();
					var table_2_clicked_col = $('#join_' + table_2 + ' tr.clicked td').eq(0).text();
					var table_1_type = $('#join_' + table_1 + ' tr.clicked td').eq(1).text();
					var table_2_type = $('#join_' + table_2 + ' tr.clicked td').eq(1).text();
					
					if(table_1_clicked_col != "" && table_2_clicked_col != ""){
						if(table_1_type == table_2_type){
							var str = table_1_clicked_col + '=' + table_2_clicked_col;
							var tag = "<li><span class='table_1_clicked_col'>" + table_1_clicked_col + 
							"</span><span>=</sapan><span class='table_2_clicked_col'>" + table_2_clicked_col + "</span></li>";
							$('#join-expression').append(tag);
							
							changeTrClassName("", t);						
						}else{
							var err_msg = common.getToDay() + " [Join Error] join 대상 컬럼의 타입이 일치하지 않습니다.";
							$("#state_msg_div").append("<div>" + err_msg + "</div>");
						}
					}else{
						var err_msg = common.getToDay() + " [Join Error] join할 컬러을 선택하셔야 됩니다.";
						$("#state_msg_div").append("<div>" + err_msg + "</div>");
					}
					
					break;
					
				case 'Order':
					var add_col_name = $('#order-table').find('tr.clicked')
							.children().eq(0).text();
					var sort_order_tag = "<tr>"
							+ "<td>"
							+ add_col_name
							+ "</td>"
							+ "<td><select name='order_type' class='order_type'><option value='asc'>ASC</option><option value='desc'>DESC</option></select></td>"
							+ "</tr>";
					$("#sort-order-table").append(sort_order_tag);
					changeTrClassName("", t);
					break;

				case 'Union':
					var union_type = $('#union-type-select option:selected')
							.val();
					var master = $('#union-master-select').find(
							'option:selected').val();
					var slave = $('.union-dataTableName').eq(0).text();
					if (master == slave) {
						slave = $('.union-dataTableName').eq(1).text();
					}
					var master_table = $('#union_' + master);
					var slave_table = $('#union_' + slave);
					var master_leng = master_table.children().length;
					var slave_leng = slave_table.children().length;
					var master = $('#union-master-select').find(
							'option:selected').val();
					var slave = $('.union-dataTableName').eq(0).text();
					var master_col = $('#union_' + master + ' tr.clicked td')
							.eq(0).text();
					var master_type = $('#union_' + master + ' tr.clicked td')
							.eq(1).text();
					var slave_col = $('#union_' + slave + ' tr.clicked td').eq(
							0).text();
					var slave_type = $('#union_' + slave + ' tr.clicked td')
							.eq(1).text();
					var tag = "";
					var err_msg;
					var tag = "";
					var add_type = $(
							":input:radio[name=union-add-type]:checked").val();
					// master테이블의 속성 갯수가 일치하는 판단
					if (master_leng == slave_leng) {
						if (add_type == 'Manual') {
							// 수작업으로 컬럼 매치 할 경우 선택한 걸럼의 타입이 일치하는지 판단
							if (master_col != "") {
								if (master_type == slave_type) {
									unionManualAdd(add_type, t);
								} else {
									// 에러 처리 부분
									err_msg = common.getToDay()
											+ " [Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
									$("#state_msg_div").append(
											"<div>" + err_msg + "</div>");
								}
							} else {
								// 에러 처리 부분
								err_msg = common.getToDay()
										+ " [Union Error] 컬럼을 선택하셔야 됩니다.";
								$("#state_msg_div").append(
										"<div>" + err_msg + "</div>");
							}
						} else {
							// 오토 컬럼 매치
							// 이름과 타입이 일치하지 않은 녀석들은 auto add에 선택 되어 있더라도 메뉴얼로
							// 수작업 할 수
							// 있도록 auto add 도중 남은 상태인지를 auto add 개수로 판단
							var auto_added_length = $('#union-contents-container table tr.Auto_added').length;
							if (master_type == slave_type) {
								if (auto_added_length == 0) {
									for (var i = 0; i < master_leng; i++) {
										var master_class_name = slave_table
												.children().eq(i).attr('class');

										// manual로 하는 도중에 auto로 할 수 있으므로 비어 있는
										// 것만 실시,
										// click만 하고 add 안했을수도 있으므로 clicked로 추가
										if (master_class_name == null
												|| master_class_name == 'clicked') {
											var master_tr_text = master_table
													.children().eq(i).text();

											for (var j = 0; j < slave_leng; j++) {
												var slave_class_name = slave_table
														.children().eq(j).attr(
																'class');
												var slave_tr_text = slave_table
														.children().eq(j)
														.text();

												if (slave_class_name == null
														|| slave_class_name == 'clicked') {
													if (master_tr_text == slave_tr_text) {
														master_col = master_table
																.children().eq(
																		i)
																.children().eq(
																		0)
																.text();
														slave_col = slave_table
																.children().eq(
																		j)
																.children().eq(
																		0)
																.text();
														master_type = master_table
																.children().eq(
																		i)
																.children().eq(
																		1)
																.text();

														master_table
																.children()
																.eq(i)
																.attr('class',
																		'clicked');
														slave_table
																.children()
																.eq(j)
																.attr('class',
																		'clicked');

														tag += "<tr><td>"
																+ master_col
																+ "</td>"
																+ "<td>"
																+ slave_col
																+ "</td>"
																+ "<td>"
																+ master_type
																+ "</td></tr>";
														$("#union-match-table")
																.append(tag);
														tag = "";
														// 색깔 바꿔 주면서 class 이름을
														// "add타입_added"로 해줌.
														changeTrClassName(
																add_type, t);
													}
												}
											}
										}
									}
								} else {
									if (master_col != "") {
										if (master_type == slave_type) {
											// 자동 add 안된 컬럼들 수동 add 처리 부분
											unionManualAdd(add_type, t);
										} else {
											// 에러 처리 부분
											err_msg = common.getToDay()
													+ " [Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
											$("#state_msg_div").append(
													"<div>" + err_msg
															+ "</div>");
										}
									} else {
										// 에러 처리 부분
										err_msg = common.getToDay()
												+ " [Union Error] 컬럼을 선택하셔야 됩니다.";
										$("#state_msg_div").append(
												"<div>" + err_msg + "</div>");
									}
								}
							} else {
								// 에러 처리 부분
								err_msg = common.getToDay()
										+ " [Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
								$("#state_msg_div").append(
										"<div>" + err_msg + "</div>");
							}
						}

					} else {
						// 에러 처리 부분
						err_msg = common.getToDay()
								+ " [Union Error] 테이블들의 속성 갯수가 일치하지 않습니다.";
						$("#state_msg_div")
								.append("<div>" + err_msg + "</div>");
					}
					
					break;

				case 'Addition':
					var col_name = $('#addition-col-name').val();
					var expression = $('#addition-expression').val();
					var tag = "";
					if(expression.trim() != ""){
						tag += "<tr><td>"
							+ col_name
							+ "</td>"
							+ "<td>"
							+ expression
							+ "</td></tr>";
						$("#add-col-expression-table").append(tag);
					}else{
						err_msg = common.getToDay()
						          + " [Addition Error] expression 항목을 작성시기 바랍니다.";
						$("#state_msg_div").append("<div>" + err_msg + "</div>");
					}
					
					break;
				
				case 'Rename' :
					var to_tags = renewalToChildInfoTableTag();
					$('#rename-add-table').html(to_tags);
					 $('#rename-table tr td input.addition-renwal-name').each(function(){
						 var val = $(this).val();
						 $(this).attr('value', val);
					 })
					break;
				}
			}
		};
	}

	return {
		// Get the Singleton instance if it exists
		// or create one if doesn't
		getInstance : function() {
			// dbReadTag = $('#dbread-setting-bar').html();
			if (!instance) {
				// console.log("setting 인스턴스 생성");
				instance = createInstance();
			}
			return instance;
		}
	};
})();