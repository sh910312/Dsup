<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function() {
		getBackup();
	});
	
	// [윤정1113] 백업 조회 요청
	function getBackup() {
		$.ajax({
			url: 'getAdminBackup',
			type: 'GET',
			dataType: 'json',
			success: printBackup
		});
	}
	
	// [윤정1113] 백업 목록 출력
	function printBackup(backup) {
		$.each(backup, function(idx, item) {
			var userId = $("<td>").text((item.userId));
			var filename = $("<td>").text((item.backupFileNm));
			var backupDate = $("<td>").text((item.backupDate).substr(0,10));
			var backupComment = $("<td>").text((item.backupComment));
			
			$("#userBackupTableTbody").append( $("<tr>").append(userId)
										.append(filename)
										.append(backupDate)
										.append(backupComment)
							);
		});
		$('#userBackupTable').DataTable();
	}
</script>

<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 백업
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered table-hover" id="userBackupTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>아이디</th>
						<th>백업파일 이름</th>
						<th>백업 날짜</th>
						<th>코멘트</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>아이디</th>
						<th>백업파일 이름</th>
						<th>백업 날짜</th>
						<th>코멘트</th>
					</tr>
				</tfoot>
				<tbody id = "userBackupTableTbody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>