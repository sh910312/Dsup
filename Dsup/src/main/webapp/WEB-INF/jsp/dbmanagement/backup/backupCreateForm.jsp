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
		//dfList();
		//$("#tablespaceName").change(dfList);
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
			var $radio = $("<td>").append($("<input>").attr("name","tablespaceName").attr("type","radio").val((item.tablespaceName)));
			$("tbody").append($("<tr>").append($radio).append("<td>" + (item.tablespaceName) + "</td>"));
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
	<h1>테이블스페이스 선택</h1>
	<form id="frm" method="post" action="backupCreate">
		<table border = "1" id = "tb">
			<tbody></tbody>
		</table>
		아이디<input type = "text" name = "userId">
		코멘트<input type = "text" name = "backupComment">
		<input type = "submit" id = "backupBtn" value = "백업하기">
	</form>
</body>
</html>