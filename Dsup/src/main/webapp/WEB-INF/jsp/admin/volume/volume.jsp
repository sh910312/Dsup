<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!-- Google Chart-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- Script For Google Chart Draw  -->
<script type="text/javascript">
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var request = new XMLHttpRequest();
	var result = "";
	//관리자 페이지의 어떤 메뉴를 선택 했는지에 다라 Ajax url이 달라짐
	var menu = "";
	
	var url = "getTableSpaceCondition";
 	request.open("GET", url, false);

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			result = request.responseText;
		    console.log("Result : " + result);
		}
	};
	request.send(null);
  var data = google.visualization.arrayToDataTable([
    ['TBSPC_NM', 'Total_Size', 'Used_Size'],
    ['LJM089_TBSPC', 1000, 400],
    ['YJ_TBSPC', 1000, 745],
    ['MG_TBSPC', 1000, 120],
    ['MG_TBSPC', 1000, 621],
    ['MG_TBSPC', 1000, 5]
  ]);

  var options = {
    chart: {
      title: 'Company Performance',
      subtitle: 'Sales, Expenses, and Profit: 2014-2017',
    },
    bars: 'horizontal' // Required for Material Bar Charts.
  };

  var chart = new google.charts.Bar(document.getElementById('chart_div'));

  chart.draw(data, google.charts.Bar.convertOptions(options));
}
</script>
<div class="container-fluid">
	<h6>Administrator Page</h6>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">Volume</a></li>
		<li class="breadcrumb-item active">#</li>
	</ol>
	<h6>Volume Condition Menu</h6>
	<div>
		<jsp:include page="conditionMenu.jsp"></jsp:include>
	</div>

	<h6>Current Volume Condition</h6>
	<div>
		<jsp:include page="currentVolumeCondition.jsp"></jsp:include>
	</div>

	<!-- <h6>DataTables Example</h6> -->
	<div>
		<jsp:include page="datatable.jsp"></jsp:include>
	</div>
</div>