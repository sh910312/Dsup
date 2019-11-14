<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- <script>
  	$(function(){
		getTsTable();
	});
	
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
		$.each(data, function(idx, item) {
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
		});
		
		$('#tsTable').DataTable();
	}
</script> -->
<!-- Google Chart Section -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-chart-area"></i> Area Chart Example
	</div>
	<div class="card-body">
		<div class="chartjs-size-monitor">
			<div class="chartjs-size-monitor-expand">
				<div class=""></div>
			</div>
			<div class="chartjs-size-monitor-shrink">
				<div class=""></div>
			</div>
		</div>
		<!-- Google Chart Canvas -->
		<div id="chart_div" style="width: 900px; height: 500px;"></div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday
		at 11:59 PM</div>
</div>
<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 테이블스페이스
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="tsTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>사용자 아이디</th>
						<th>테이블스페이스 명</th>
						<th>상태</th>
						<th>전체 용량 (MB)</th>
						<th>사용중인 용량 (MB)</th>
						<th>빈 용량 (MB)</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>사용자 아이디</th>
						<th>테이블스페이스 명</th>
						<th>상태</th>
						<th>전체 용량 (MB)</th>
						<th>사용중인 용량 (MB)</th>
						<th>빈 용량 (MB)</th>
					</tr>
				</tfoot>
				<tbody id = "tsTableTbody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>