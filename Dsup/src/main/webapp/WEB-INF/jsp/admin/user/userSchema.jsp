<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>