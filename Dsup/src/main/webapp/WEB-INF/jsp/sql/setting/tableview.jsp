<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<!-- <script src="./resources/js/sql/etc/jquery.dragtable.js"></script> -->
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<title>Insert title here</title>
<%
	String sql = request.getParameter("sql");
	String rowCount = request.getParameter("rowCount");
	System.out.println("tableview.jsp | sql : " + sql);
	System.out.println("tableview.jsp | rowCount : " + rowCount);
%>
<script>
var dataTable;
$(window).scroll(function(event){
	var currnetRowCount = <%=rowCount%>;
	var tableTrCount = $('#dataTable tbody tr').length;
	var windowScrollTop = $(window).scrollTop();
	var documentHeight = $(document).height();
	var windowHeight = $(window).height();
	console.log("1.$(document).height() - $(window).height() : " + ($(document).height() - $(window).height()));
	console.log("2.Math.floor($(window).scrollTop()) : " + Math.floor($(window).scrollTop()));
	console.log("Scrolling...")
	if(($(document).height() - $(window).height()) - Math.floor($(window).scrollTop()) == 0){
		console.log("Scroll End!!");
		//모든 데이터를 다 가지고온게 아니라면 스크롤이 끝에 오면 데이터를 더 가지고 온다.
		if(currnetRowCount != tableTrCount){
			var newRowCount = tableTrCount + 100;
			getOtherData(newRowCount);
		}
	}
/* 	if($(window).scrollTop() > $(document).height() - $(window).height()){
		console.log("Scroll End!!");
		//모든 데이터를 다 가지고온게 아니라면 스크롤이 끝에 오면 데이터를 더 가지고 온다.
		if(currnetRowCount != tableTrCount){
			var newRowCount = tableTrCount + 100;
			getOtherData(newRowCount);
		}
	} */
});
function getOtherData(param){
	var sql = "<%=sql%>";
	var newRowCount = param;
	
	$.ajax({
		  url: 'getOtherData',
		  type: 'GET',
		  data: {
			  sql : sql,
			  newRowCount : newRowCount
		  },
		  dataType: 'json',
		  success: function(response) {
			  //var rowcount = reponse.ROWCOUNT;
		  	//console.log(response);
	 	 	var newTableTag = makeNewTableTag(response);
//		  	dataTable.destroy();
			//opener : 부모창
			$("#dataTable").html(newTableTag);
			//$('#dataTable').dragtable();
/* 		    dataTable = $('#dataTable').DataTable( {
		    	"paging":   false,
		        "ordering": false,
		        "info":     false
		   } );  */
		  },
		  fail: function(error) {
		    // 실패 시 동작
		  },
		  always: function(response) {
		    // 성공하든 실패하든 항상 할 동작
		  }
		});
}

function makeNewTableTag(json){
	// console.log("jsonLength : " + jsonLength);
	var rownum = 1;
	var tag = '';
	var thead = '';
	var tbody = '';
	for (var key in json) {
		//<thead>만드는 부분
		if(key == "COL_NAME"){
			var a_json = json[key];
			thead = thead + 
				'<tr style="font-weight: bold;">' +
					'<td></td>';
			for(var i=0; i<json[key].length; i++){
				thead = thead + 
					'<th>' + json[key][i] + '</th>';
			}
			thead = thead+
				'</tr>';
		//<tbody>만드는 부분
		}else if(key == "DATA"){
			var a_json = json[key];
		
			for(a_key in a_json){
				tbody = tbody +
				'<tr>' +
					'<td>' + a_key + '</td>';
				for(var i=0; i<a_json[a_key].length; i++){
					tbody = tbody + 
					'<td>' + a_json[a_key][i] + '</td>';
				}
			}
			tbody = tbody + '</tr>';
			rownum += 1;
		}
	}
	tag = '<thead>' + thead + '</thead><tbody>' + tbody + '</tbody>';
	
	return tag;
}

$(function() {
  	$(document).ready(function() {
  		
		//opener : 부모창
		$("#dataTable").html(opener.table_tag);
		//$('#dataTable').dragtable();
 /* 	    dataTable = $('#dataTable').DataTable( {
 	    	"paging":   false,
 	        "ordering": false,
 	        "info":     false
	    });  */
	});
});
</script>
</head>
<body>
	<div>
		<table id="dataTable" class="table table-hover" border=1></table>
	</div>
</body>
</html>