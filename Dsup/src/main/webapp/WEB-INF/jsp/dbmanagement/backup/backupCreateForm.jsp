<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Backup</title>
	
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
	$(function(){
		tsList();
		dfList();
		$("#tsList").change(dfList);
	});
	
	// [1024] 테이블스페이스 리스트 요청
	function tsList() {
		$.ajax({
			url : 'tablespaceList',
			type : 'GET',
			dataType : 'json',
			success: tsListResult
		});
	}
	
	// [1024] 테이블스페이스 리스트 응답
	function tsListResult(ts) {
		$.each(ts, function(idx, item){
			$("#tsList").append($("<option>").val(item.tablespaceName).text(item.tablespaceName));
		});
	} 
	
	// [1024] 데이터파일 리스트 요청
	function dfList(){
		var tsName = $("#tsList").val();
		console.log(tsName)
		$.ajax({
			url : 'datafileList/' + tsName,
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
			dataType : 'json',
			success: dfListResult
		});
	}
	
	// [1024] 데이터파일 리스트 출력
	function dfListResult(df) {
		$("tbody").empty();
		$.each(df, function(idx, item){
			console.log(item.fileName);
			var $tr = $("<tr>").append($("<td>").append($("<input>").attr("type","checkbox").val((item.fileName))))
								.append($("<td>").text((item.fileName)));
			$("tbody").append($tr);
		});
	}
	
	
	</script>

</head>
<body>

</body>
</html>