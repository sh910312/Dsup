<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(function() {
		getPayHistory();
	});
	
	// [윤정1111] 결제내역 조회 요청
	function getPayHistory() {
		$.ajax({
			url: 'payHistory',
			type: 'GET',
			dataType: 'json',
			success: printPayHistory
		});
	}
	
	// [윤정1111] 결제내역 출력
	function printPayHistory(payHistory){
		$.each(payHistory, function(idx, item) {
			var paySeq = $("<td>").text((item.paySeq));
			var userId = $("<td>").text((item.userId));
			var payDate = $("<td>").text((item.payDate));
			var payItem = $("<td>").text((item.payItem));
			var payType = $("<td>").text((item.payType));
			var payPrice = $("<td>").text((item.payPrice));
			
			$("#payHistoryTableTbody").append( $("<tr>").append(paySeq)
										.append(userId)
										.append(payDate)
										.append(payItem)
										.append(payType)
										.append(payPrice)
						);
		});
		
		$('#payHistoryTable').DataTable();
	}
</script>

<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 결제 이력
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="payHistoryTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>결제번호</th>
						<th>사용자 아이디</th>
						<th>결제일자</th>
						<th>결제수단</th>
						<th>결제수단</th>
						<th>가격</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>결제번호</th>
						<th>사용자 아이디</th>
						<th>결제일자</th>
						<th>결제수단</th>
						<th>결제수단</th>
						<th>가격</th>
					</tr>
				</tfoot>
				<tbody id = "payHistoryTableTbody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>