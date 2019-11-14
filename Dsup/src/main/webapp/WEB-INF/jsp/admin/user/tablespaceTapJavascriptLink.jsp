<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Script For Google Chart Draw  -->
<script type="text/javascript">
function userPageChange(type) {
	   $(".yj_user").css("display", "none");
	   //재문 추가
	   if(type == "userTablespace"){
		   getTsTable();
	   }
	   $("#" + type).css("display", "block");
}
// 윤정
/* $(function(){
	getTsTable();
}); */

// [윤정1111] 조회 요청
function getTsTable() {
	$.ajax({
		url : 'getAdminStorage',
		type : 'GET',
		dataType : 'json',
		success : printTsTable
	});
}

function printTsTable(data) {
	//누를때마다 테이블에 컬럼들이 추가 되서 바꿈
/* 	$.each(data, function(idx, item) {
		console.log("data : " + data);
		var userId = $("<td>").text((item.userId));
		var tablesapceName = $("<td>").text((item.tablespaceName));
		var status = $("<td>").text((item.status));
		var total = $("<td>").text((item.total));
		var used = $("<td>").text((item.used));
		var free = $("<td>").text((item.free));
		
		$("#tsTableTbody").append( $("<tr>").append(userId)
											.append(tablesapceName)
											.append(status)
											.append(total)
											.append(used)
											.append(free)
				);
	}); */
	var tag = "";
	$.each(data, function(idx, item) {
		var userId = item.userId;
		var tablesapceName = item.tablespaceName;
		var status = item.status;
		var total = item.total;
		var used = item.used;
		var free = item.free;
		tag += "<tr>" +
					"<td>" + userId + "</td>" +
					"<td>" + tablesapceName + "</td>" +
					"<td>" + status + "</td>" +
					"<td>" + total + "</td>" +
					"<td>" + used + "</td>" +
					"<td>" + free + "</td>" +
				"</tr>";
	});
	$("#tsTableTbody").html(tag);
	$('#tsTable').DataTable({
		"lengthMenu": [5, 10, 25, 50]
	});
	//테이블 만들고 테이블에 있는 내용에 따라 차트 만들어짐
	drawChart('tbspc');
}

/* //datatable 생성
$(document).ready(function() {
	$('#tsTable').DataTable({
		"lengthMenu": [5, 10, 25, 50]
	});
	//테이블 만들고 테이블에 있는 내용에 따라 차트 만들어짐
	drawChart('tbspc');
}); */
//datatable에 의해 동적으로 만들어진 tr태그의 정보를 변수에 저장 하는 부분
function getTrTagInfoOfDataTable(obj){
	var result=[];
	var subject = obj;
	var subjectValue = "";
	var total_size = "";
	var used_size = "";
	var tbodyId = "";
	if(subject == "tbspc"){
		result.push(['Tablespace', 'Total_Size', 'Used_Size']);
		tbodyId = "#tsTableTbody tr";
	}else if(subject == "payhistory"){
	}
	$(tbodyId).each(function(){
		var inner_list = [];
		if(subject == "tbspc"){
			subjectValue = $(this).children().eq(1).text();
			total_size = Number($(this).children().eq(3).text());
			used_size = Number($(this).children().eq(4).text());
		}else if(subject == "user"){
		}			
/* 		}else if(subject == "datafile"){
			subjectValue = $(this).children().eq(1).text();
			total_size = Number($(this).children().eq(2).text());
			used_size = Number($(this).children().eq(3).text());
		} */
		
		inner_list.push(subjectValue);
		inner_list.push(total_size); 
		inner_list.push(used_size);
		
		result.push(inner_list);
	});
	
	return result;
}

google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

//차트 그리는 부분
function drawChart(obj) {
	console.log(getTrTagInfoOfDataTable(obj));
	var type = obj;
	//초기 차트 필요 없을 때도 실행 되서 구글 차트가 필요한 텝을 클릭할 때만 그리도록 조건문 추가함
	if(type != undefined){
		var dataList = getTrTagInfoOfDataTable(obj);
		var data = google.visualization.arrayToDataTable(dataList);
		
		//나중에 더 추가할 그래프 있는지 확인하기 위해 if문 넣어둠
		var title = "";
		if(type == "tbspc"){
			title = "Tablespace Name";
		}
		
		var groupWidthOfbar = "50%";
		var trCnt = $('#tsTableTbody tr').length;
		$('#chart_div').css("height", trCnt + '00px');
		
	 	var options = {
	      chart: {
	          title: 'Database Volume Chart',
	          //subtitle: 'Based on most recent and previous census data'
	        },
	        hAxis: {
	          title: 'Total Population',
	          minValue: 0,
	        },
	        vAxis: {
	          title: title
	        },
	        bars: 'horizontal',
	        bar: { groupWidth: groupWidthOfbar },
	        axes: {
	          y: {
	            0: {side: 'right'}
	          }
	        }
	  	};
	
	  	var chart = new google.charts.Bar(document.getElementById('chart_div'));
	
	  	chart.draw(data, google.charts.Bar.convertOptions(options));
	}
}


$(document).on("change click keyup paste input propertychange", "a, .page-link, .custom-select, .sorting_desc, .sorting_asc, .form-control", function(obj){
	console.log("이벤트 발생");
	drawChart('tbspc');
});
</script>