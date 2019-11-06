<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Backup</title>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
		
		$('input:radio[name="tablespaceName"]').eq(0).attr("checked", true);
		// 첫 번째 라디오 자동 체크
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<h1>테이블스페이스 선택</h1>
	<form id="frm" method="post" action="backupCreate">
		<table id = "tb" class = "table table-hover table-bordered">
			<thead>
				<tr>
					<th></th>
					<th>테이블스페이스 이름</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<input type = "hidden" name = "userId" value="${userId}">
		<div class = "row">
			<label for="backupComment" class="col-1 col-form-label">코멘트</label>
			<div class = "col-8">
				<input type = "text" name = "backupComment" id = "backupComment"
						class = "form-control">
			</div>
			<div class = "col-1">
				<input type = "submit" id = "backupBtn" value = "백업하기" class = "btn btn-info">
			</div>
			<div class = "col-1">
				<input type = "submit" id = "backupBtn" value = "뒤로가기" class = "btn btn-secondary">
			</div>
		</div>
	</form>
</div>
</body>
</html>