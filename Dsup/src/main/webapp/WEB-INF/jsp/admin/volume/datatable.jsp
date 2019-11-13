<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</script>
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 
		<h6 style="display:inline; ">Table Space Info Table</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<span id="admin-volume-datatable-type" style="display:none;">tbspc</span>
			<table class="table table-bordered" id="test-table" width="100%" cellspacing="0">
				<thead id="admin-thead-volume">
					<tr>
						<th>Tablespace Name</th>
						<th>Total Size(MB)</th>
						<th>Used Size(MB)</th>
						<th>Free Size(MB)</th>
						<th>Used Percent(%)</th>
					</tr>
				</thead>
				<tbody id="admin-tbody-volue">
				</tbody>
			</table>
		</div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
</div>
