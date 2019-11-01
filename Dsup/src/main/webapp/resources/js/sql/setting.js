var Setting = (function() {
	// instance stores a reference to the Singleton
	var instance;

	function createInstance() {
		// private variables and methods
		var dbReadTag = $('#dbread-setting-bar').html();
		var filterTag = $('#filter-setting-bar').html();
		var joinTag = $('#join-setting-bar').html();
		var additionTag = $('#addition-setting-bar').html();
		var orderTag = $('#order-setting-bar').html();
		var unionTag = $('#union-setting-bar').html();
		var renameTag = $('#rename-setting-bar').html();
		var dbInsertTag = $('#dbinsert-setting-bar').html();

		function click(obj) {
			var tbody = obj.parentNode;
			var trs = tbody.getElementsByTagName('tr');
			var orgBColor = '#ffffff';
			var toBColor = "#c0c0c0";

			for (var i = 1; i < trs.length; i++) {
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
			//master와 slave 테이블이 어떤 건지 찾는 부분
			var master = $('#union-master-select').find('option:selected').val();
			var slave = $('.union-dataTableName').eq(0).text();
			if (master == slave) {
				slave = $('.union-dataTableName').eq(1).text();
			}
			//master와 slave 테이블에서 선택된 컬럼과 타입을 찾는 부분
			var master_col = $('#union_' + master + ' tr.clicked td').eq(0)
					.text();
			var master_type = $('#union_' + master + ' tr.clicked td').eq(1)
					.text();
			var slave_col = $('#union_' + slave + ' tr.clicked td').eq(0)
					.text();
			var slave_type = $('#union_' + slave + ' tr.clicked td').eq(1)
					.text();
			var tag = "";
			//최종적으로 추가된 컬럼과 타입 쌍을 테이블 열로 추가 하기위한 태그 만드는 부분
			tag += "<tr><td>" + master_col + "</td>" + "<td>" + slave_col
					+ "</td>" + "<td>" + master_type + "</td></tr>";
			$("#union-match-table").append(tag);
			// 추가된 열의 상태값을 변경헤주는 부분
			changeTrClassName(add_type, t);
		}
		
		function dbInsertManualAdd(add_type, t){
			var input_col = $('#dbinsert-table tr.clicked td').eq(0).text();
			$('#dbinsert-target-table tr.clicked td').eq(3).text(input_col)

			changeTrClassName(add_type, t);
		}

		function changeTrClassName(add_type, t) {
			var toBColor = "#f5f5dc";
			var table = $('#' + t.toLowerCase() + '-contents-container table tr');
			var table_length = table.length;
			for (var i = 0; i < table_length; i++) {
				var tr = $('#' + t.toLowerCase() + '-contents-container table tr.clicked');
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

		function renewalToChildInfoTableTag() {
			var checked_col_length = $('#rename-table tr td input:checked').length;

			var tag = "<tr><th>From</th><th>To</th></tr>";

			for (var i = 0; i < checked_col_length; i++) {
				var from_col = $('#rename-table tr td input:checked').eq(i)
						.parent().siblings().eq(0).text().toUpperCase();
				var to_col = $('#rename-table tr td input:checked').eq(i)
						.parent().siblings().eq(2).children().val()
						.toUpperCase();
				if (to_col == "") {
					to_col = from_col;
				}
				// var checked_col_index = $('#rename-table
				// tr').index($('#rename-table tr td
				// input:checked').eq(i).parent().parent())
				tag = tag + '<tr>' + '<td>' + from_col + '</td>' + '<td>'
						+ to_col + '</td>' + '</tr>';
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
								tag = tag
										+ '<tr>'
										+ '<td>'
										+ '<input type="checkbox" name="renewal-col-checkbox" value="'
										+ b_key
										+ '" checked onclick="controller.selectChanged(this);"/>'
										+ '</td>'
										+ '<td>'
										+ b_key
										+ '</td>'
										+ '<td>'
										+ b_json[b_key]
										+ '</td>'
										+ '<td><input type="text" class="addition-renwal-name" name="addition-renwal-name" style="border:none"/></td>'
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
						//'width' : '50%'
					});

					break;
				// 동영
				case 'Filter':
					console.log("filter on");
					$('#filter-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;
				case 'Join':
					$('#join-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;

				case 'Addition':
					$('#addition-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;
				case 'Order':
					$('#order-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;
				case 'Union':
					$('#union-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;
				case 'Rename':
					$('#rename-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;
				case 'DBinsert':
					$('#dbinsert-setting-bar').css({
						'display' : 'block',
						//'width' : '50%'
					});
					break;

				}

//				$('#textarea-container').css({
//					'display' : 'block',
//					'width' : '40%'
//				});
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
				case 'DBinsert':
					console.log("Rename off");
					$('#dbinsert-setting-bar').css({
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
				case 'Rename':
					console.log("Rename clean()");

					$('#rename-setting-bar').html(renameTag);
					break;
				case 'DBinsert':
					console.log("Rename clean()");

					$('#rename-setting-bar').html(dbInsertTag);
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
							$('#filter-table-list').append(tags[key]);
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
							$('#join-dataTableName-' + i).append(key);
							$('#join-dataTable-' + i).append(tags[key]);
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
						var renewal_tags = renewalFromChildInfoTableTag(info);

						$('#addition-name').html(t);
						$('#addition-key').html(k);

						for ( var key in add_tags) {
							$('#additon-table').append(add_tags[key]);
						}

						for ( var key in renewal_tags) {
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
							$('#order-table').append(tags[key]);
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
							//테이블에 열추가하는 부분
							$('#union-dataTable-' + i).append(tags[key]);
							$('#union-master-mark-div-' + i).attr('id', 'union-master-mark-' + key);
							$('#union-dataTable-' + i).attr('id', "union_" + key);
							i += 1;
						}
					} else {
						$('#union-setting-bar').html(info);
					}

					break;
				case 'Rename':
					if (n == "new") {
						$('#rename-name').html(t);
						$('#rename-key').html(k);
						var from_tags = renewalFromChildInfoTableTag(info);

						for (key in from_tags) {
							$('#rename-table').append(from_tags[key]);
						}

						var to_tags = renewalToChildInfoTableTag();

						$('#rename-add-table').html(to_tags);
					} else {
						$('#rename-setting-bar').html(info);
					}
				case 'DBinsert':
					if (n == "new") {
						$('#dbinsert-name').html(t);
						$('#dbinsert-key').html(k);
						var tags = makeChildInfoTableTag(info);
						
						for (key in tags) {
							$('#dbinsert-table').append(tags[key]);
						}
						
					} else {
						$('#dbinsert-setting-bar').html(info);
					}
				}
			},
			tableClick : function(obj) {
				if ($(obj).parent().attr('id') != 'additon-table') {
					click(obj);
				} else {
					click(obj);
					var type = $('#additon-table tr.clicked td').eq(1).text();
					$('#additon-operaters-div .selected-col-type').html(type);
					$('#additon-operaters-div').css("display", "block");
				}

			},
			tableDoubleClick : function(obj) {
				if ($(obj).parent().attr('id') != "additon-operaters-div") {
					var td_text = $(obj).children().eq(0).text();
					$('#addition-col-name').val(td_text);
					click(obj);
				} else if ($(obj).parent().attr('id') == "additon-operaters-div") {
					var col = $('#additon-table tr.clicked td').eq(0).text();
					var operater = $(obj).text();
					var split_temp = operater.split('(');
					operater = split_temp[0];
					var expression = operater + "(" + col + ")";
					$('#addition-expression').val(expression);
				}
			},
			decoTargetTable : function(info){
				var json = JSON.parse(info);
				var tag = "";
				var original_tag = "<tr><th>Data Type</th><th>Target Col</th><th>=</th><th>Input Col</th></tr>";
				for(var i=0; i<json.length; i++){
					tag += "<tr>" +
					 		  "<td>" + json[i].dataType + "</td>" +
					          "<td class='target_col'>" + json[i].colName + "</td>" +
					          "<td>=</td>" + 
					          "<td class='input_col'></td>" +
					       "</tr>";
				}
				$('#dbinsert-target-table').html(original_tag);
				$('#dbinsert-target-table').append(tag);
			},
			selectChanged : function(obj) {
				console.log("<select> changed!");
				var change_type = $(obj).attr('name');
				var select_tag_id = $(obj).attr('id');
				
				//Target Table의 선택된 option태그에 selected 속성 부여 하는 부분
				$('#'+select_tag_id+' option').each(function(){
					$(this).removeAttr('selected');
				});
				$('#'+select_tag_id+' option:selected').attr("selected", "selected");
				
				//선택된 Target table 컬럼의 타입과 동일한 input 테이블의 컬럼을 select 태그에 추가해주는 부분 
				if(change_type == 'where-stmt-select'){
					var selected_target_col = $('#where-stmt-target-select option:selected').text();
					var selecte_target_col_type = $('#dbinsert-table tr td:contains("' + selected_target_col + '")')
														.eq(0).siblings().text();
					var same_type_input_col_leng = 
						$('#dbinsert-table tr td:contains("' + selecte_target_col_type + '")').length;
					var tag = "<option></option>";
					if(select_tag_id == "where-stmt-target-select"){
						for(var i=0; i<same_type_input_col_leng; i++){
							var same_type_input_col = 
								$('#dbinsert-table tr td:contains("' + selecte_target_col_type + '")').eq(i).siblings().text();
							tag += "<option>" + same_type_input_col + "</option>";
						}
						$('#where-stmt-input-select').html(tag);
						
					}
				}
				
				if(change_type == 'dbinsert-select'){
					var select_tag_id = $(obj).attr('id');
					
					//Target Table의 선택된 option태그에 selected 속성 부여 하는 부분
					$('#'+select_tag_id+' option').each(function(){
						$(this).removeAttr('selected');
					});
					$('#'+select_tag_id+' option:selected').attr("selected", "selected");
					
					//Columns Matching에 Target테이블을 선택할 때마다 해당 테이블의 컬럼을 select태그로 만들어 주는 부분
					var target_table_col_len = $('#dbinsert-target-table tr').length;
					var tag = "<option></option>";
					for(var i=1; i<target_table_col_len; i++){
						var target_col = $('#dbinsert-target-table tr').eq(i).children().eq(1).text();
						tag += "<option>" + target_col + "</option>"
					}
					$('#where-stmt-target-select').html(tag);
					
					//Excution Mode에서 Insert나 Delete가 선택 됐을 경우에만 Where Statement 쓸 수 있도록 설정 하는 부분
					if(select_tag_id=='dbinsert-mode'){
						var select_val = $('#'+select_tag_id+' option:selected').val();
						
						if(select_val == 'Insert' || select_val == 'Delete'){
							$('#dbinsert-execution-table select').attr("disabled", "disabled");
						}else{
							$('#dbinsert-execution-table select').removeAttr("disabled");
						}
					}
				}else if(change_type == 'dbinsert-add-type'){
					$('.dbinsert-add-type').each(function(){
						$(this).removeAttr('checked');
					})
					$(obj).attr('checked', 'checked');
				}else if(change_type == 'union-add-type'){
					$('.union-add-type').each(function(){
						$(this).removeAttr('checked');
					})
					$(obj).attr('checked', 'checked');
				}else if (change_type == 'renewal-col-checkbox') {
					if ($(obj).is(':checked')) {
						$(obj).parent().siblings().children().attr('disabled',
								false);
						$(obj).parents('tr').css('background-color', 'white');
						$(obj).attr("checked", 'checked');
					} else {
						$(obj).parent().siblings().children().attr('disabled',
								true);
						$(obj).parents('tr').css('background-color', '#ebebe4');
						$(obj).removeAttr("checked")
					}
				} else if (change_type == 'order_type') {
					var sel = $(obj).val();
					$(obj.children).removeAttr('selected');
					$(obj.children).each(function() {
						if ($(this).val() == sel) {
							$(this).attr('selected', 'selected');
						}
					})
				} else {
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
			decorateTargetTableList : function(list) {
				var tag = "";
				var json = JSON.parse(list);
				$('#target_table_list').html("<option>Choice Table</option>");
				for (var i = 0; i < json.length; i++) {
					tag += "<option id='" + json[i] + "' class='targetlist''>"
							+ json[i] + "</option>";
				}
				$('#target_table_list').append(tag);
			},
			add : function(t) {

				switch (t) {
				case 'Join':
					var joinType = $(":input:radio[name=joinType]:checked")
							.val();
					var table_1 = $('#join-dataTableName-1').text();
					var table_1_clicked_length = $('#join_' + table_1 + ' tr.clicked').length;
					var table_2 = $('#join-dataTableName-2').text();
					var table_2_clicked_length = $('#join_' + table_2 + ' tr.clicked').length;
					var table_1_clicked_col = $('#join_' + table_1 + ' tr.clicked td').eq(0).text();
					var table_2_clicked_col = $('#join_' + table_2 + ' tr.clicked td').eq(0).text();
					var table_1_type = $('#join_' + table_1 + ' tr.clicked td').eq(1).text();
					var table_2_type = $('#join_' + table_2 + ' tr.clicked td').eq(1).text();

					if (table_1_clicked_col != "" && table_2_clicked_col != "") {
						if(table_1_clicked_length == table_2_clicked_length){
							if (table_1_type == table_2_type) {
								var str = table_1_clicked_col + '='
										+ table_2_clicked_col;
								var tag = "<li><span class='table_1_clicked_col'>"
										+ table_1_clicked_col
										+ "</span><span>=</sapan><span class='table_2_clicked_col'>"
										+ table_2_clicked_col + "</span></li>";
								$('#join-expression').append(tag);

								changeTrClassName("", t);
							} else {
								var err_msg = "[Join Error] join 컬럼의 타입이 일치하지 않습니다.";
								common.errorMessage(err_msg);
							}
						}else{
							var err_msg = "[Join Error] join 컬럼을 선택해주십시오.";
							common.errorMessage(err_msg);
						}
					} else {
						var err_msg = "[Join Error] join 컬럼을 선택해주십시오.";
						common.errorMessage(err_msg);
					}

					break;

				case 'Order':
					if($('#order-table tr.clicked').length == 1){
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
					}else{
						var err_msg = "[Order Error] 하나 이상의 컬럼을 선택 하셔야 됩니다.";
						common.errorMessage(err_msg);
					}
					
					break;

				case 'Union':
					var union_type = $('#union-type-select option:selected').val();
					var add_type = $(":input:radio[name=union-add-type]:checked").val();
					var master = $('#union-master-select').find('option:selected').val();
					var slave = $('.union-dataTableName').eq(0).text();
					if (master == slave) {
						slave = $('.union-dataTableName').eq(1).text();
					}
					var master_table_tr = $('#union_' + master + ' tr');
					var slave_table_tr = $('#union_' + slave + ' tr');
					var master_leng = master_table_tr.length;
					var slave_leng = slave_table_tr.length;
					var master_col = $('#union_' + master + ' tr.clicked td').eq(0).text();
					var master_type = $('#union_' + master + ' tr.clicked td').eq(1).text();
					var slave_col = $('#union_' + slave + ' tr.clicked td').eq(0).text();
					var slave_type = $('#union_' + slave + ' tr.clicked td').eq(1).text();
					var err_msg = "";
					var tag = "";
					// master테이블의 속성 갯수가 일치하는 판단
					if (master_leng == slave_leng) {
						if (add_type == 'Manual') {
							// 수작업으로 컬럼 매치 할 경우 선택한 걸럼의 타입이 일치하는지 판단
							if (master_col != "") {
								if (master_type == slave_type) {
									unionManualAdd(add_type, t);
								} else {
									// 에러 처리 부분
									err_msg = "[Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
									common.errorMessage(err_msg);
								}
							} else {
								// 에러 처리 부분
								err_msg = "[Union Error] 컬럼을 선택하셔야 됩니다.";
								common.errorMessage(err_msg);
							}
						} else {
							// 오토 컬럼 매치
							// 이름과 타입이 일치하지 않은 녀석들은 auto add에 선택 되어 있더라도 메뉴얼로
							// 수작업 할 수
							// 있도록 auto add 도중 남은 상태인지를 auto add 개수로 판단
							var auto_added_length = $('#union-contents-container table tr.Auto_added').length;
							if (master_type == slave_type) {
								if (auto_added_length == 0) {
									for (var i = 1; i < master_leng; i++) {
										//var master_class_name = slave_table.children().eq(i).attr('class');
										// manual로 하는 도중에 auto로 할 수 있으므로 비어 있는 것만 실시,
										// click만 하고 add 안했을수도 있으므로 clicked로 추가
										var master_tr_text = master_table_tr.eq(i).text();

										for (var j = 1; j < slave_leng; j++) {
											var slave_tr_text = slave_table_tr.eq(j).text();
											if (master_tr_text == slave_tr_text) {
												master_col = master_table_tr.eq(i).children().eq(0).text();
												slave_col = slave_table_tr.eq(j).children().eq(0).text();
												master_type = master_table_tr.eq(i).children().eq(1).text();

												master_table_tr.eq(i).attr('class', 'clicked');
												slave_table_tr.eq(j).attr('class', 'clicked');

												tag += "<tr><td>"
														+ master_col
														+ "</td>"
														+ "<td>"
														+ slave_col
														+ "</td>"
														+ "<td>"
														+ master_type
														+ "</td></tr>";
												$("#union-match-table").append(tag);
												tag = "";
												// 색깔 바꿔 주면서 class 이름을
												// "add타입_added"로 해줌.
												changeTrClassName(add_type, t);
											}
										}
									}
								} else {
									//auto로 add 되지 않은 컬럼들 처리해주는 부분
									if (master_col != "") {
										if (master_type == slave_type) {
											// 자동 add 안된 컬럼들 수동 add 처리 부분
											unionManualAdd(add_type, t);
										} else {
											// 에러 처리 부분
											err_msg = "[Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
											common.errorMessage(err_msg);
										}
									} else {
										// 에러 처리 부분
										err_msg = "[Union Error] 컬럼을 선택하셔야 됩니다.";
										common.errorMessage(err_msg);
									}
								}
							} else {
								// 에러 처리 부분
								err_msg = "[Union Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
								common.errorMessage(err_msg);
							}
						}

					} else {
						// 에러 처리 부분
						err_msg = "[Union Error] 테이블들의 속성 갯수가 일치하지 않습니다.";
						common.errorMessage(err_msg);
					}

					break;

				case 'Addition':
					var col_name = $('#addition-col-name').val();
					var expression = $('#addition-expression').val();
					var tag = "";
					if (expression.trim() != "") {
						tag += "<tr><td>" + col_name + "</td>" + "<td>"
								+ expression + "</td></tr>";
						$("#add-col-expression-table").append(tag);
					} else {
						err_msg = "[Addition Error] expression 항목을 작성시기 바랍니다.";
						common.errorMessage(err_msg);
					}

					break;

				case 'Rename':
					var to_tags = renewalToChildInfoTableTag();
					$('#rename-add-table').html(to_tags);
					$('#rename-table tr td input.addition-renwal-name').each(
							function() {
								var val = $(this).val();
								$(this).attr('value', val);
							})
					break;
					
				case 'DBinsert' :
					var input_table_tr = $('#dbinsert-table tr');
					var target_table_tr = $('#dbinsert-target-table tr');
					var add_type = $(":input:radio[name=dbinsert-add-type]:checked").val();
					var taget_table_length = $('#dbinsert-target-table').length;
					var err_msg="";
					var input_col = $('#dbinsert-table tr.clicked td').eq(0).text();
					var input_col_type = $('#dbinsert-table tr.clicked td').eq(1).text();
					var target_col = $('#dbinsert-target-table').eq(0).text();
					var target_col_type = $('#dbinsert-target-table tr.clicked td').eq(0).text();
					if(taget_table_length != 0){
						if(add_type == 'Manual'){
							//Manual일때 처리
							// 수작업으로 컬럼 매치 할 경우 선택한 걸럼의 타입이 일치하는지 판단
							if (input_col != "" && target_col !="") {
								//타입 일치 체크
								if (input_col_type == target_col_type) {
									dbInsertManualAdd(add_type, t);
								} else {
									// 에러 처리 부분
									err_msg = "[DBinsert Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
									common.errorMessage(err_msg);
								}
							} else {
								// 에러 처리 부분
								err_msg = "[DBinsert Error] 컬럼을 선택하셔야 됩니다.";
								common.errorMessage(err_msg);
							}
						}else{
							//Auto일때 처리
							var auto_added_length = $('#dbinsert-contents-container table tr.Auto_added').length;
							if (auto_added_length == 0){
								//auto로 처음 add 시키는 상황
								var input_table_length = $('#dbinsert-table tr').length;
								var target_table_length = $('#dbinsert-target-table tr').length;
								
								for(var i=1; i<input_table_length; i++){
									//empnovarchar
									var input_col_txt = $('#dbinsert-table tr').eq(i).children().text();
									//empno
									input_col = $('#dbinsert-table tr').eq(i).children().eq(0).text();
									//varchar
									input_col_type = $('#dbinsert-table tr').eq(i).children().eq(1).text();
									for(var  j=1; j<target_table_length; j++){
										var target_col = $('#dbinsert-target-table tr').eq(j).children().eq(1).text();
										var target_type = $('#dbinsert-target-table tr').eq(j).children().eq(0).text();
										//empnovarchar
										var target_col_txt = target_col + target_type;
										if(input_col_txt == target_col_txt){
											input_table_tr.eq(i).attr('class', 'clicked');
											target_table_tr.eq(j).attr('class',	'clicked');
											$('#dbinsert-target-table tr.clicked td').eq(3).text(input_col);
//											tag += "<tr><td class='target_col'>"
//												+ target_col
//												+ "</td>" +
//												"<td>=</td>" +
//												+ "<td class='input_col'>"
//												+ input_col
//												+ "</td>"
//												+ "<td class='type'>"
//												+ target_col_type
//												+ "</td></tr>";
//										$("#dbinsert-execution-table").append(tag);
//										tag = "";
										// 색깔 바꿔 주면서 class 이름을
										// "add타입_added"로 해줌.
										changeTrClassName(add_type, t);
										}
									}//End for(var j)
								}//End for(var i)
							}else{
								//auto로 add 되지 않은 컬럼들 처리해주는 부분
								if (master_col != "") {
									if (master_type == slave_type) {
										// 자동 add 안된 컬럼들 수동 add 처리 부분
										dbInsertManualAdd(add_type, t);
									} else {
										// 에러 처리 부분
										err_msg = "[DBinsert Error] 선택한 컬럼의 타입이 일치하지 않습니다.";
										common.errorMessage(err_msg);
									}
								} else {
									// 에러 처리 부분
									err_msg = "[DBinsert Error] 컬럼을 선택하셔야 됩니다.";
									common.errorMessage(err_msg);
								}//master_col == ""
							}//auto_added_length != 0
						}//taget_table_length == 0
					}else{
						err_msg = "[DBinsert Error] Insert할 Target DB를 선택하십시오.";
						common.errorMessage(err_msg);
					}
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