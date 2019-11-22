<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Script For Google Chart Draw  -->
<script type="text/javascript">

//관리자 페이지 시작화면으로 사용자 관리 메뉴의 내용을 부러주기 위해 존재
$(function() {
	getMember();
});
//테이블스페이스 jQuery datatable 인스턴스 저장 변수
var tablespaceTable = "";
//사용자관리 jQuery datatable 인스턴스 저장 변수
var userManagementTable = "";
//메뉴 클릭할 때마다 내용 변경해주는 function 부르는  function
function userPageChange(type) {
   	$(".yj_user").css("display", "none");
   	if(type == "userTablespace"){
	//테이블스페이스 메뉴 클릭할 때
	   	getTsTable();
		$(".breadcrumb > .active").text("테이블 스페이스"); // 윤정 breadcrumb
   	}else if(type == "userManagement"){
	//사용자 관리 메뉴 클릭할 때
	   	getMember();
		$(".breadcrumb > .active").text("사용자 관리");
	} else if(type == "userSchema") {
		$(".breadcrumb > .active").text("유저 스키마");
	} else if(type == "payHistory") {
		$(".breadcrumb > .active").text("결제 이력");
	} else if(type == "userBackup") {
		$(".breadcrumb > .active").text("백업");
	}
   	$("#" + type).css("display", "block");
}
//사용자관리 테이블에 넣을 데이터 Ajax호출
function getMember() {
	$.ajax({
		url : 'members',
		type : 'GET',
		dataType : 'json',
		success : printMember
	});
}
//사용자관리 테이블의 태그 생성과 jQuery datatable 생성하는 부분
function printMember(member) {
	var tag = "";
	$.each(member, function(idx, item) {
		var userId = item.userId;
		var nickname = item.nickname;
		var email = item.eMail;
		var userDate = item.userDate;
		var phonenumber = item.phonenumber;
		var userType = item.userType;
		var payItem = item.payItem;
		var volumn = item.volumn;

		if (userType == '1') userType = '일반회원';
		else if (userType == '0') userType = '관리자';
		else if(userType == '2') userType = '탈퇴';
		
		$("#memberTableTbody").append(
			$( $("<tr>").append( $("<td>").text(userId) )
						.append( $("<td>").text(nickname) )
						.append( $("<td>").text(email) )
						.append( $("<td>").text(userDate) )
						.append( $("<td>").text(phonenumber) )
						.append( $("<td>").text(userType) )
						.append( $("<td>").text(payItem) )
						.append( $("<td>").text(volumn + " GB") )
			)
		);
	});
	if(userManagementTable != ""){
		console.log("사용자 관리 테이블 파괴");
		userManagementTable.destroy();
	}
	//사용자 관리 jQuery datatable 생성
	userManagementTable = $('#memberTable').DataTable({
		 "lengthMenu": [5, 10, 25, 50]
	});
	//drawChart('user');
}
//테이블스페이스 테이블에 넣을 데이터 Ajax호출
function getTsTable() {
	$.ajax({
		url : 'getAdminStorage',
		type : 'GET',
		dataType : 'json',
		success : printTsTable
	});
}
//테이블스페이스 테이블의 태그 생성과 jQuery datatable 생성하는 부분
function printTsTable(data) {
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
	if(tablespaceTable != ""){
		console.log("테이블스페이스 관리 테이블 파괴");
		tablespaceTable.destroy();
	}
	//테이블 스페이스 jQuery datatable 생성
	tablespaceTable = $('#tsTable').DataTable({
		"lengthMenu": [5, 10, 25, 50]
	});
	//테이블 만들고 테이블에 있는 내용에 따라 차트 만들어짐
	drawChart('tbspc');
}

//datatable에 의해 동적으로 만들어진 tr태그 정보를 수집하여 차트에 필요한 데이터를 얻기 위한 function
function getTrTagInfoOfDataTable(obj){
	var result=[];
	var subject = obj;
	
	if(subject == "tbspc"){
	//테이블스페이스 메뉴의  Bar 차트 그리는데 필요한 데이터 가공하는 부분		
		result.push(['Tablespace', 'Total_Size', 'Used_Size']);
		var tbodyId = "#tsTableTbody tr";
		$(tbodyId).each(function(){
			var inner_list = [];
			var tablespace_name = $(this).children().eq(1).text();
			var total_size = Number($(this).children().eq(3).text());
			var used_size = Number($(this).children().eq(4).text());
			inner_list.push(tablespace_name);
			inner_list.push(total_size); 
			inner_list.push(used_size);
			result.push(inner_list);
		});
	}else if(subject == "user"){
	//사용자 관리 메뉴의 Pie 차트 그리는데 필요한 데이터 가공하는 부분
		var oneGB_cnt = 0;
		var twentyFiveMB_cnt = 0;
		var fiftyMB_cnt = 0;
		var tbodyId = "#memberTableTbody tr";
		result.push(["Pay Item", "Count"]);
		//사용자의 구매 용량의 총합 구하는 부분 
		$(tbodyId).each(function(){
			var volume = $(this).children().eq(7).text();
			if(volume == "1GB"){
				oneGB_cnt += 1;
			}else if(volume == "0.25GB"){
				twentyFiveMB_cnt += 1;
			}else if(volume == "0.5GB"){
				fiftyMB_cnt += 1;
			}
		});
		//차트 그리기 위해 던져줄 배열 변수 만드는 부분
		for(var i=0; i<3; i++){
			var inner_list = [];
			if(i==0){
				inner_list.push("1GB");
				inner_list.push(oneGB_cnt);
				result.push(inner_list);
			}else if(i==1){
				inner_list.push("0.25GB");
				inner_list.push(twentyFiveMB_cnt);
				result.push(inner_list);
			}else if(i==2){
				inner_list.push("0.5GB");
				inner_list.push(fiftyMB_cnt);
				result.push(inner_list);
			}
		}
	}
	console.log("테이블에서 빼내온 result : " + result);
	
	return result;
}

google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

//테이블스페이스 바 차트 그리는 function
function drawChart(obj) {
	var type = obj;
	if(type != undefined){
		//초기 차트 필요 없을 때도 실행 되서 구글 차트가 필요한 텝을 클릭할 때만 그리도록 조건문 추가함
		var dataList = getTrTagInfoOfDataTable(obj);
		var data = google.visualization.arrayToDataTable(dataList);

		var groupWidthOfbar = "50%";
		var trCnt = $('#tsTableTbody tr').length;
		
		//나중에 더 추가할 그래프 있는지 확인하기 위해 if문 넣어둠
		var title = "";
		if(type == "tbspc"){
			$('#tablespace_chart_div').css("height", trCnt + '00px');
			title = "Tablespace Name";
		}
		
		
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
	 	var chart;
	 	if(type == "tbspc"){
		  	chart = new google.charts.Bar(document.getElementById('tablespace_chart_div'));
	 	}else if(type == "user"){
	 		chart = new google.charts.Bar(document.getElementById('usermanagement_chart_div'));
	 	}

	  	chart.draw(data, google.charts.Bar.convertOptions(options));
	}
}


//사용자관리 파이 차트 그리는 function
/* function drawChart2(obj) {
	if(obj != undefined){
		var dataList = getTrTagInfoOfDataTable(obj);
		var data = google.visualization.arrayToDataTable(dataList);

	  	var options = {
	    	title: 'Count Of Pay Item'
	  	};

	  	var chart = new google.visualization.PieChart(document.getElementById('usermanagement_chart_div'));

	  	chart.draw(data, options);
	}
} */

//각종 이벤트 핸들러
$(document).on("change click keyup paste input propertychange", "a, .page-link, .custom-select, .sorting_desc, .sorting_asc, .form-control", function(obj){
	console.log("이벤트 발생");
	drawChart('tbspc');
	//drawChart2('user');
});
</script>