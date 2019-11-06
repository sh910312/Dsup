<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Backup List</title>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<!-- 토스트 css -->
	<link rel = "stylesheet" href="./resources/css/Toast.css">
	
	<script>
	$(function(){
		backupList();
		$("#delBtn").click(del);
		totalCheck();
		$("#modalDelBtn").click(modalDelClick);
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
			var $backupFileNm = $("<td>").html("<a href = './download/" + fileName + "'>" + fileName + "</a>");
			var $backupDate = $("<td>").text((item.backupDate).substr(0,10));
			var $backupComment = $("<td>").text((item.backupComment));
			
			$("tbody").append($("<tr>").append($checkBox)
										.append($backupFileNm)
										.append($backupDate)
										.append($backupComment)
								);
			
		});
		
		// 체크시 행 색상 변경
		$("table").on("click", $("td input"), function(){
	   		 console.log("클릭!");
	   	     $("td input").each(function(i, o){
	   	         if( $(this).is(":checked") ) {
	   	             $(this).closest("tr").addClass("table-info");
	   	         } else {
	   	         	$(this).closest("tr").removeClass("table-info");
	  	          }
		       })
	    })
	}
	
	// [윤정 1029] 삭제 버튼 클릭
	function del() {
		var checkArr = [];
		$("input[name='deleteFiles']:checked").each(function(i){
			checkArr.push($(this).val());
		});
		// 체크한 백업파일의 이름을 checkArr 배열에 담음
		
		if(checkArr.length == 0) { // 체크 개수가 0개이면
			$("#checkError").fadeIn(400).delay(1000).fadeOut(400);
		} else {
            $("#modalDel").modal("show");
    		$("#delCheck").addClass("is-invalid").val("");
    		$("#modalDelBtn").attr("disabled", true);
    		
    		$("#delCheck").keyup(function(){
    			var name = "${userId}";
    			var inputName = $("#delCheck").val();
    			
    			if(name == inputName) {
    				$("#delCheck").removeClass("is-invalid");
    				$("#delCheck").addClass("is-valid");
    				$("#modalDelBtn").attr("disabled", false);
    			} else {
    				$("#delCheck").addClass("is-invalid");
    				$("#delCheck").removeClass("is-valid");
    				$("#modalDelBtn").attr("disabled", true);
    			}
    		})
		}
	}
	
	// [윤정 1106] 모달에서 삭제버튼 클릭
	function modalDelClick(){
		$("#frm").submit();
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
<div class = "container">
	<div class="btn-group" role="group" aria-label="Basic example">
		<input type = "button" value = "백업하기" onclick = "location.href='./backupCreateForm'"
			class = "btn btn-outline-info">
		<input type = "button" id="delBtn" value = "삭제"
			class = "btn btn-outline-info" >
	</div>
	
	<form action="backupDelete" id = "frm">
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
	</form>
</div>
		<!-- [윤정1106] 삭제할 파일 체크 안했을 때 토스트 출력 -->
		<div class='yj_error' style='display:none' id="checkError">삭제할 파일을 선택해주세요!</div>

		<!-- [윤정1106] 삭제시 모달 등장 - 확인 -->
		<div class="modal fade" id="modalDel" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">경고</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						삭제한 백업파일은 복구할 수 없습니다. 삭제하려면 아이디를 입력하세요. <br>
						<input type = "text" id = "delCheck" class = "form-control" placeholder="아이디 입력">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-info" id = "modalDelBtn">삭제</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>