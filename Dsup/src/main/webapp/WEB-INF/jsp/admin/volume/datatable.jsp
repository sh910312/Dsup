<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js" defer="defer"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap4.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" rel="stylesheet">
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap4.min.css" rel="stylesheet">
<!-- jQuery DataTable -->
<script>
	$(document).ready(function() {
		$('#test-table').DataTable({
			responsive : true
		});
	});
</script>
<script>
/* function getTableSpaceCondition(){
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
} */
</script>
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 
		<h6 style="display:inline; ">Table Space Info Table</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="test-table" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>Tablespace Name</th>
						<th>Total Size(MB)</th>
						<th>Used Size(MB)</th>
						<th>Free Size(MB)</th>
						<th>Used Percent(%)</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Tiger Nixon</td>
						<td>System Architect</td>
						<td>Edinburgh</td>
						<td>61</td>
						<td>2011/04/25</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
</div>
