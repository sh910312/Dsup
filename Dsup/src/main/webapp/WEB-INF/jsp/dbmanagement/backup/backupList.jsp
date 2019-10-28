<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Backup List</title>
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

	<script>
	$(function(){
		backupList();
		deleteBtn();
	})
	
	// [윤정 1028] 백업리스트 테이블 조회 요청
	function backupList(){
		$.ajax({
			url : 'backup',
			type : 'GET',
			dataType :'json',
			success : backupListResult
		});
	}
	
	// [윤정 1028] 백업리스트 테이블 응답
	function backupListResult(result){
		$.each(result, function(idx, item){
			var fileName = (item.backupFileNm).split("\\");
			var fileName = fileName[fileName.length - 1];
			console.log(fileName);
			// fileName : 경로를 제외한 파일명만 추출
			
			var $backupFileNm = $("<td>").html("<a href = './download/" + fileName + "'>" + (item.backupFileNm) + "</a>");
			var $backupDate = $("<td>").text((item.backupDate));
			var $backupComment = $("<td>").text((item.backupComment));
			var $delBtn = $("<td>").append($("<input>").attr("type", "button").attr("id", "delBtn").val("삭제"));
			
			$("tbody").append($("<tr>").append($backupFileNm)
										.append($backupDate)
										.append($backupComment)
										.append($delBtn)
								);
		});
	}
	
	// [윤정 1028] 삭제 버튼 클릭
	function deleteBtn() {
		$("#delBtn").click(function(){
			var filename = $(this).closest("tr").find("td:eq(0)").text();
			console.log(filename);
		})
	}
	
	</script>
</head>
<body>
	<a href = "backupCreateForm">백업하기</a>
	
	<form action = "backupDelete">
	<input type = "hidden" name = "backupFileNm">
	<table border = "1" id = "table">
		<thead>
			<tr>
				<th>백업파일 이름</th>
				<th>백업 날짜</th>
				<th>코멘트</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</form>
</body>
</html>