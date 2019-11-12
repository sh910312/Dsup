<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	getUserSchema();
});

// [윤정1111] 조회 요청
function getUserSchema() {
	$.ajax({
		url : 'userSchema',
		type : 'GET',
		dataType : 'json',
		success : printTsTable
	});
}

function printUserSchema(userSchema) {
	$.each(userSchema, function(idx, item) {
		var id = $("<td>").text((item.id));
		var user = $("<td>").text((item.user));
		var status = $("<td>").text((item.accountStatus));
		var ts = $("<td>").text((item.defaultTableSpace));
		
		$("#userSchemaTableTbody").append( $("<tr>")
											.append(id)
											.append(user)
											.append(status)
											.append(ts)
				);
		
		$('#userSchemaTable').DataTable();
	});
}
</script>
    
<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 유저 스키마
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="userSchemaTable" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>사용자 아이디</th>
						<th>유저 스키마 아이디</th>
						<th>상태</th>
						<th>디폴트 테이블스페이스</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>사용자 아이디</th>
						<th>유저 스키마 아이디</th>
						<th>상태</th>
						<th>디폴트 테이블스페이스</th>
					</tr>
				</tfoot>
				<tbody id = "userSchemaTableTbody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>