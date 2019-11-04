<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Backup List</title>
	<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	<script>
	$(function(){
		backupList();
		$("#delBtn").click(del);
		changeTr();
		totalCheck();
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
			// fileName : 경로를 제외한 파일명만 추출
			
			var $checkBox = $("<td>").append($("<input>").attr("type","checkbox").val((item.backupFileNm)).attr("name", "deleteFiles"));
			var $backupFileNm = $("<td>").html("<a href = './download/" + fileName + "'>" + (item.backupFileNm) + "</a>");
			var $backupDate = $("<td>").text((item.backupDate).substr(0,10));
			var $backupComment = $("<td>").text((item.backupComment));
			//var $delBtn = $("<td>").append($("<input>").attr("type", "button").attr("class", "delBtn").val("삭제"));
			
			
			$("tbody").append($("<tr>").append($checkBox)
										.append($backupFileNm)
										.append($backupDate)
										.append($backupComment)
								);
			
		});
	}
	
	// [윤정 1029] 삭제 버튼 클릭
	function del() {
		var checkArr = [];
		$("input[name='deleteFiles']:checked").each(function(i){
			checkArr.push($(this).val());
		});
		// 체크한 백업파일의 이름을 checkArr 배열에 담음
		
		if(checkArr.length == 0) { // 체크 개수가 0개이면
			alert("삭제할 파일을 체크해주세요!");
		} else {
			var reply = confirm("삭제하시겠습니까?");
			if(reply == true) {
				$("#frm").submit();
			}
		}
	}
	
	// [윤정 1029] 체크박스 클릭시 tr 색상 변경
	function changeTr(){
		$("table").on("click", $("td input"), function(){
            $("td input").each(function(i, o){ 
                if($(this).is(":checked")){
                    $(this).closest("tr").addClass('info');
                } else {
                    $(this).closest("tr").removeClass('info');
                }
            })
        })
	}
	
	// [윤정 1029] thead의 체크박스 클릭시 전체 선택, 해제
	function totalCheck(){
		$("#checkAll").click(function(){
			if($("#checkAll").prop("checked")){
				$("input[name='deleteFiles']").prop("checked", true);
			} else {
				$("input[name='deleteFiles']").prop("checked", false);
			}
		});
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
	<a href = "backupCreateForm" >백업하기</a>
	<form action="backupDelete" id = "frm">
	<div class = ".table-responsive">
	<table id = "table"  class="table table-hover">
		<thead>
			<tr>
				<th><input type = "checkbox" id="checkAll"></th>
				<th>백업파일 이름</th>
				<th>백업 날짜</th>
				<th>코멘트</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</div>
	<input type = "button" id="delBtn" value = "삭제">
	</form>
</body>
</html>