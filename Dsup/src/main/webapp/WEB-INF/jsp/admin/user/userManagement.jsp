<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	/* $(function() {
		getMember();
	});
	
	// [윤정1111] 사용자 조회 요청
	function getMember() {
		$.ajax({
			url: 'members',
			type: 'GET',
			dataType: 'json',
			success: printMember
		});
	}
	
	// [윤정1111] 사용자 목록 출력
	function printMember(member) {
		$.each(member, function(idx, item) {
			var userId = $("<td>").text((item.userId));
			var password = $("<td>").text((item.password));
			var nickname = $("<td>").text((item.nickname));
			var email = $("<td>").text((item.eMail));
			var userDate = $("<td>").text((item.userDate));
			var phonenumber = $("<td>").text((item.phonenumber));
			var userType = $("<td>").text((item.userType));
			var payItem = $("<td>").text((item.payItem));
			
			$("#memberTableTbody").append( $("<tr>").append(userId)
										.append(password)
										.append(nickname)
										.append(email)
										.append(userDate)
										.append(phonenumber)
										.append(userType)
										.append(payItem)
							);
		});
		
		$('#memberTable').DataTable({
			 "lengthMenu": [5, 10, 25, 50]
		});
	} */
</script>
<!-- Google Chart Section -->
<div class="card mb-3" style="display:none;">
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
		<div id="usermanagement_chart_div" style="width: 900px; height: 500px;"></div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday
		at 11:59 PM</div>
</div>
<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 사용자 관리
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered table-hover" id="memberTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>가입일</th>
						<th>연락처</th>
						<th>등급</th>
						<th>종량제</th>
						<th>사용량</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>가입일</th>
						<th>연락처</th>
						<th>등급</th>
						<th>종량제</th>
						<th>사용량</th>
					</tr>
				</tfoot>
				<tbody id = "memberTableTbody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>