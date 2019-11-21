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
			var nameOnly = (item.backupFileNm).split("\\");
			nameOnly = nameOnly[nameOnly.length - 1];
			// nameOnly : 경로를 제외한 파일명만 추출
			
			var file = (item.backupFileNm).split("\\Dsup\\");
			file = file[file.length - 1];
			
			var userId = $("<td>").text((item.userId));
			var filename = $("<td>").html("<a href = './download/" + nameOnly + "'>" + file + "</a>");
			var backupDate = $("<td>").text((item.backupDate).substr(0,10));
			var retentionPeriod = $("<td>").text((item.retentionPeriod).substr(0,10));
			var backupComment = $("<td>").text((item.backupComment));
			
			$("#userBackupTableTbody").append( $("<tr>").append(userId)
										.append(filename)
										.append(backupDate)
										.append(retentionPeriod)
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
			<table class="table table-bordered table-hover" id="userBackupTable" width="100%" cellspacing="0"
					style="table-layout:fixed;word-break:break-all;">
				<thead>
					<tr>
						<th style="width:10%">아이디</th>
						<th style="width:20%">백업파일 이름</th>
						<th style="width:10%">백업 날짜</th>
						<th style="width:10%">보관 기간</th>
						<th style="width:50%">코멘트</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>아이디</th>
						<th>백업파일 이름</th>
						<th>백업 날짜</th>
						<th>보관 기간</th>
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