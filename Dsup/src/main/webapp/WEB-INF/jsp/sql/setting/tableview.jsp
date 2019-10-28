<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<script src="./resources/js/sql/etc/jquery.dragtable.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="./resources/css/etc/dragtable.css" /> -->
<title>Insert title here</title>
<script>
  	$(document).ready(function() {
  		
		//var tag = localStorage.getLocalStorage(k, "DISPLAY_TABLE_TAG");;
		console.log(opener.table_tag);
		//opener : 부모창
		$("#dataTable").append(opener.table_tag);
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