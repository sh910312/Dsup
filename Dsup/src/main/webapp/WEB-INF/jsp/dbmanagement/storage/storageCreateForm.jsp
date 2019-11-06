<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Storage</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<!-- 토스트 css -->
	<link rel = "stylesheet" href="./resources/css/Toast.css">
	<script>
	$(function(){
		$("#btn").click(formCheck);
		$("#addbtn").click(add);
		tsNameChkFunction();
		$("#nameMsg").hide();
		filenameInput();
	});
	
	// 제출 전 확인
	function formCheck(){
		var tsname = $("#tablespaceName").val();
		var datafile = "";
		
		$("tbody>tr").each(function(){
			var filename = $(this).find("#filename").val();
			var size = $(this).find("#size").val();
			var sizeunit = $(this).find("#sizeunit").val();
			
			if(isNaN(size) || size == 0){
				$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
				return false;
			}
			
			datafile += " '" +  "${sessionScope.member.userId}" + "_" + filename + ".dbf' size " + size + sizeunit + ","
			
			console.log(datafile);
		});
		datafile = datafile.substring(0, datafile.length-1); // 맨 마지막 , 제거
		// 데이터파일 입력한 값을 '데이터파일명.dbf' size 0m, ... 로 양식에 맞게 만들어 datafile의 값에 저장
		
		var sql = "create tablespace " + tsname + " datafile " + datafile
				+ " LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO";
		$("#sql").val(sql);
	}
	
	// 데이터파일 추가
	function add(){
		var $filename = $("<input>").attr("type","text").attr("id","filename").attr("required",true).attr("class", "form-control").attr("readonly", true); // 이름 입력칸
		var $size = $("<input>").attr("type","text").attr("id","size").attr("required",true).attr("class", "form-control"); // 용량 입력칸
		var $sizeunit = $("<select>").attr("id","sizeunit").attr("class", "form-control")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB"))
									.append($("<option>").val("T").text("TB")); // 용량 단위
		var $btn = $("<input>").attr("type","button").attr("id","delbtn").val("삭제")
							.click(function(){	$(this).parent().parent().remove();
												filenameInput();
											})
							.attr("class", "btn btn-outline-secondary"); // 삭제 버튼
		
		var $tr = $("<tr>")
						.append($("<td>").append($filename))
						.append( $("<td>").append( $("<div class = 'row'>")
												.append( $("<div class = 'col-9'>").append($size) )
												.append( $("<div class = 'col-3'>").append($sizeunit) )
										)
								)
						//.append( $("<td>").append($size).append($sizeunit) )
						.append($("<td>").append($btn)); // 위의 칸들을 하나의 tr로 붙임
		$("#tb1").append($tr); // 테이블에 tr 추가
		
		filenameInput();
	}
	
	// [윤정 1031] 테이블스페이스명 유효성 검사 
	function tsNameChkFunction() {
		$("#tablespaceName").blur(function(){
			var name = $("#tablespaceName").val();
			name = name.toUpperCase();
			$("#tablespaceName").val(name);
			$("#tablespaceName").addClass("is-invalid");
			
			// 아이디를 입력하지 않은 경우
			if(name == '') { 
				$("#nameMsg").show().text("이름을 입력해주세요");
				$("#btn").attr("disabled", true);
				
				return;
			}
			
			// [윤정1101] 이름 첫 글자 영어만
			if(!name.substr(0,1).match(/[A-Z]/)) {
				$("#nameMsg").show().text("이름 첫 글자는 영어만 입력할 수 있습니다");
				$("#btn").attr("disabled", true);
				return;
			}
			
			// [윤정 1101] 이름에 A-Z, 0-9, _ 만 쓸 수 있도록
			var err = 0;
			var cnt = name.length;
			console.log('---- 검사 시작');
			for(i = 0; i < cnt; i ++) {
				var chk = name.charAt(i);
				if (!chk.match(/[0-9]/) && !chk.match(/[A-Z]/) && chk != '_'){
					err = err + 1;
				}
				if(err > 0) {
					$("#nameMsg").show().text("영어, 숫자, _만 입력할 수 있습니다");
					$("#btn").attr("disabled", true);
					return;
				}
			}
			// end [윤정 1101] 이름에 A-Z, 0-9, _ 만 쓸 수 있도록
		
			$.ajax({
				url : "tsNameChk?tablespaceName=" + name,
				type : 'GET',
				success : function(data) {
					// 중복이면 0, 아니면 1
					if(data == 0) { // 중복
						$("#nameMsg").show().text("사용할 수 없는 이름입니다");
						$("#btn").attr("disabled", true);
					} else { // 중복x
						$("#nameMsg").hide();
						$("#btn").attr("disabled", false);
						$("#tablespaceName").removeClass("is-invalid");
					}
				}
			}) // ajax
			
			filenameInput();
		}); // .blur(function)
	} // tsNameChkFunction
	
	// [윤정1101] 데이터파일명 지정
	function filenameInput(){
		var cnt = 1;
		var name = $("#tablespaceName").val();
		$("tbody>tr").each(function(){
			$(this).find("#filename").val(name + "_" + cnt);
			cnt++;
		});
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<form onsubmit="return formCheck()" method = "post" action = "storageCreate">
	<input type = "hidden" id = "sql" name = "sql">
		<div class ="row">
			<h1>테이블 스페이스</h1>
		</div>
		<div class = "row">
			<div class = "col-3">
				 이름
			</div>
			<div class = "col-9">
				<input type = "text" name = "tablespaceName" id = "tablespaceName" required class = "form-control"> 
				<div class="invalid-feedback" id = "nameMsg"></div>
			</div>
		</div>
		
		<div class = "row">
			<h1>데이터 파일</h1>
		</div>
		<table id = "tb1" class = "table table-hover table-bordered">
			<thead>
				<tr>
					<th>이름</th>
					<th>용량</th>
					<th><input type = "button" id = "addbtn" value = "추가" class = "btn btn-outline-secondary"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type = "text" id = "filename" required class = "form-control" readonly></td>
					<td>
						<div class = "row">
						<div class = "col-9">
							<input type = "text" id = "size" required class = "form-control">
						</div>
						<div class = "col-3">
						<select id = "sizeunit" class = "form-control">
							<option value = "M">MB</option>
							<option value = "K">KB</option>
							<option value = "G">GB</option>
							<option value = "T">TB</option>
						</select>
						</div>
						</div>
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<div class = "row">
			<input type = "submit" id="btn" value = "생성" class = "btn btn-info btn-block">
			<input type = "button" id="back" value = "목록으로 돌아가기" class = "btn btn-light btn-block"
					onclick = 'history.back()'>
		</div>
		
		<div class='yj_error' style='display:none' id="sizeError">용량은 숫자만 입력할 수 있습니다!</div>
		
	</form>
</div>
</body>
</html>