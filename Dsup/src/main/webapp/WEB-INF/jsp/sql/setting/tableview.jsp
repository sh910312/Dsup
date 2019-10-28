<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<script src="../js/etc/jquery.dragtable.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/etc/dragtable.css" />
<title>Insert title here</title>
<script>
  	$(document).ready(function() {
		var tag = '${param.tag}';
		$("#dataTable").append(tag);
		$('#dataTable').dragtable();
 	    $('#dataTable').DataTable( {
	        "order": [[ 3, "desc" ]]
	    } ); 
	});  
/*  	$(document).ready(function() {
		$('#dataTable').dragtable();
	    $('#dataTable').DataTable( {
	        "order": [[ 3, "desc" ]]
	    } );
	});  */
</script>
</head>
<body>
	<table id="dataTable" border="1">

	</table>
	
	
	
</body>
</html>