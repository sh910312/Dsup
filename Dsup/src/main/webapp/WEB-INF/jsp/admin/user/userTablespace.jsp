<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function(){
		
	});
	
	// [윤정1111] 조회 요청
</script>

<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 결제 이력
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="tsTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>사용자 아이디</th>
						<th>테이블스페이스 명</th>
						<th>상태</th>
						<th>전체 용량</th>
						<th>사용중인 용량</th>
						<th>빈 용량</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>사용자 아이디</th>
						<th>테이블스페이스 명</th>
						<th>상태</th>
						<th>전체 용량</th>
						<th>사용중인 용량</th>
						<th>빈 용량</th>
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