<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Script For Google Chart Draw  -->
<script type="text/javascript">
//테이블의 tr태그 만드는 부분
function makeTableTag(result){
	var json = JSON.parse(result);
	var tag = "";
	var type = $('#admin-volume-datatable-type').text();
	
	if(type == "tbspc"){
		for(var i=0; i<json.length; i++){
			var tablespace_name = json[i].tablespace_name;
			var totalSize = json[i].total_size;
			var usedSize = json[i].used_size;
			var freeSize = json[i].free_size;
			var usedPercent = json[i].used_percent;
			
			tag += "<tr>" +
			            "<td>" + tablespace_name + "</td>" +
			            "<td>" + totalSize + "</td>" +
			            "<td>" + usedSize + "</td>" +
			            "<td>" + freeSize + "</td>" +
			            "<td>" + usedPercent + "</td>" +
			       "</tr>"
		}
	}else if(type == "user"){
		for(var i=0; i<json.length; i++){
			var user_id = json[i].user_id;
			var totalSize = json[i].total_size;
			var usedSize = json[i].used_size;
			var freeSize = json[i].free_size;
			var usedPercent = json[i].used_percent;
			
			tag += "<tr>" +
			            "<td>" + user_id + "</td>" +
			            "<td>" + totalSize + "</td>" +
			            "<td>" + usedSize + "</td>" +
			            "<td>" + freeSize + "</td>" +
			            "<td>" + usedPercent + "</td>" +
			       "</tr>"
		}
	}else if(type == "datafile"){
		for(var i=0; i<json.length; i++){
			var tablespace_name = json[i].tablespace_name;
			var file_name = json[i].file_name;
			var totalSize = json[i].total_size;
			var usedSize = json[i].used_size;
			var freeSize = json[i].free_size;
			var usedPercent = json[i].used_percent;
			
			tag += "<tr>" +
			            "<td>" + tablespace_name + "</td>" +
			            "<td>" + file_name + "</td>" +
			            "<td>" + totalSize + "</td>" +
			            "<td>" + usedSize + "</td>" +
			            "<td>" + freeSize + "</td>" +
			            "<td>" + usedPercent + "</td>" +
			       "</tr>"
		}
	}else{
		
	}
	
	return tag;
}

//테이블에 넣을 데이터 가지고 오는 부분
function doAjax(type){
	var request = new XMLHttpRequest();
	var result = "";
	//관리자 페이지의 어떤 메뉴를 선택 했는지에 다라 Ajax url이 달라짐
	var menu = "";
	var url = "";
	
	if(type == "" || type == "getTableSpaceCondition"){
		url = "getTableSpaceCondition";
	}else if(type == "getUserVolumCondition"){
		url = "getUserVolumCondition";
	}else if(type == "getDataFileVolumeCondition"){
		url = "getDataFileVolumeCondition";
	}else if(type == ""){
		url = "";
	}
	console.log("doAjax() -> URL : " + url);
	
 	request.open("GET", url, false);

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			result = request.responseText;
		    console.log("Result : " + result);
		}
	};
	request.send(null);
	
	return result;
}
//jQuery datatable에 의해 동적으로 만들어진 tr태그의 정보를 변수에 저장 하는 부분
function getTrTagInfoOfDataTable(){
	var result=[];
	var subject = $('#admin-volume-datatable-type').text();
	var subjectValue = "";
	var total_size = "";
	var used_size = "";
	result.push(['Tablespace', 'Total_Size', 'Used_Size']);
	$('#admin-tbody-volue tr').each(function(){
		var inner_list = [];
		if(subject == "tbspc"){
			subjectValue = $(this).children().eq(0).text();
			total_size = Number($(this).children().eq(1).text());
			used_size = Number($(this).children().eq(2).text());
		}else if(subject == "user"){
			subjectValue = $(this).children().eq(0).text();
			total_size = Number($(this).children().eq(1).text());
			used_size = Number($(this).children().eq(2).text());
		}else if(subject == "datafile"){
			subjectValue = $(this).children().eq(1).text();
			total_size = Number($(this).children().eq(2).text());
			used_size = Number($(this).children().eq(3).text());
		}
		
		inner_list.push(subjectValue);
		inner_list.push(total_size); 
		inner_list.push(used_size);
		
		result.push(inner_list);
	});
	
	return result;
}

//jQuery datatable 인스턴스 저장할 Global 변수
var table;

//테이블에 태그 생성하는 부분 : 로딩 시 한 번만 실행 됨
$(document).ready(function() {
	var result = doAjax("");
	var tag = makeTableTag(result);
	$('#admin-tbody-volue').html(tag);
	
	table = $('#test-table').DataTable({
		  "lengthMenu": [5, 10, 15, 20],
		  destroy: true,
	});
	
});

google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

//차트 그리는 부분
function drawChart() {
	console.log(getTrTagInfoOfDataTable());
	var type = $('#admin-volume-datatable-type').text();
	var dataList = getTrTagInfoOfDataTable();
	var data = google.visualization.arrayToDataTable(dataList);
	
	var title = "";
	if(type == "tbspc"){
		title = "Tablespace Name";
	}else if(type=="user"){
		title = "User ID";
	}else if(type=="datafile"){
		title = "Datafile Name";
	}else if(type==""){
		title = "Tablespace Name";
	}
	
	var groupWidthOfbar = "50%";
	var trCnt = $('#admin-tbody-volue tr').length;
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

$(document).on("change click keyup paste input propertychange", "a, .page-link, .custom-select, .sorting_desc, .sorting_asc, .form-control", function(obj){
	var tag_id = obj.currentTarget.id;
	console.log(tag_id);

	if(tag_id == ""){
		//테이블의 컬럼 페이징 버튼들 클릭 했을 떄
		drawChart();
	}else if(tag_id=="admin-tablespace-condition"){
		//tablespace 현황 탭 클릭 했을 때
		var result = doAjax("getTableSpaceCondition");
		$('#admin-volume-datatable-type').html("tbspc");
		var tag = makeTableTag(result);
		table.destroy();
		htmlThead();
		$('#admin-tbody-volue').html(tag);
		table = $('#test-table').DataTable({
			  "lengthMenu": [5, 10, 15, 20],
			  destroy: true,
		});
		
		drawChart();
	}else if(tag_id=="admin-user-condition"){
		//user별 tablespace 현황 탭 클릭 했을 때
		var result = doAjax("getUserVolumCondition");
		$('#admin-volume-datatable-type').html("user");
		var tag = makeTableTag(result);
		table.destroy();
		htmlThead();
		$('#admin-tbody-volue').html(tag);
		table = $('#test-table').DataTable({
			  "lengthMenu": [5, 10, 15, 20],
			  destroy: true,
		});
		
		drawChart();
	}else if(tag_id=="admin-datafile-condition"){
		//datafile 현황 탭 클릭 했을 때
		var result = doAjax("getDataFileVolumeCondition");
		$('#admin-volume-datatable-type').html("datafile");
		var tag = makeTableTag(result);
		table.destroy();
		htmlThead();
		$('#admin-tbody-volue').html(tag);
		table = $('#test-table').DataTable({
			  "lengthMenu": [5, 10, 15, 20],
			  destroy: true,
		});
		
		drawChart();
	}else{
		
	}
});

function htmlThead(){
	var tag = "";
	var type = $('#admin-volume-datatable-type').text();
	if(type=="tbspc"){
		tag = "<tr>" +
				"<th>Tablespace Name</th>" +
				"<th>Total Size(MB)</th>" +
				"<th>Used Size(MB)</th>" +
				"<th>Free Size(MB)</th>" +
				"<th>Used Percent(%)</th>" +
			  "</tr>";
	 $("#admin-thead-volume").html(tag);
	}else if(type=="user"){
		tag = "<tr>" +
				"<th>User ID</th>" +
				"<th>Total Size(MB)</th>" +
				"<th>Used Size(MB)</th>" +
				"<th>Free Size(MB)</th>" +
				"<th>Used Percent(%)</th>" +
			  "</tr>";
		$("#admin-thead-volume").html(tag);
	}else if(type=="datafile"){
		tag = "<tr>" +
				"<th>Tablespace Name</th>" +
				"<th>Datafile Name</th>" +
				"<th>Total Size(MB)</th>" +
				"<th>Used Size(MB)</th>" +
				"<th>Free Size(MB)</th>" +
				"<th>Used Percent(%)</th>" +
	 		 "</tr>";
		$("#admin-thead-volume").html(tag);
	}
}
</script>