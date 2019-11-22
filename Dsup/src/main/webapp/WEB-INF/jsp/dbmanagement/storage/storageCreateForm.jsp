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
	// [윤정1109] 종량제
	var service = "${member.payItem}".split("GB")[0];
	var freeVolumn = 0;
	var thisVolumn = 0;
	var submitCheck = 0;
	$(function(){
		$("#trCreOk").click(formCheck);
		$("#addbtn").click(add);
		$("#nameMsg").hide();
		filenameInput();
		getVolumn();
		getThisVolumn();
		$("#tablespaceName").blur(tsNameChkFunction);
	});
	
	// 제출 전 확인
	function formCheck(){
		var tsname = $("#tablespaceName").val();
		var datafile = "";
		var err = 0;
		var sizeErr = 0;
		
		if( thisVolumn > freeVolumn ) { // 종량제 제한을 초과했을 경우
			$('#volumnError').fadeIn(400).delay(1000).fadeOut(400);
			return;
		}
		
		if(tsname == '') { // 테이블스페이스 이름 입력하였는지 확인
 			$('#tsnameError').fadeIn(400).delay(1000).fadeOut(400);
			return;
		}
		
		// 이름 유효성 맞지 않으면
		if( !$("#tablespaceName").hasClass("is-valid") ) 
			err += 1;
		
		// 데이터파일 입력한 값 확인
		$("#tb1 tbody>tr").each(function(){
			var filename = $(this).find("#filename").val();
			var size = $(this).find("#size").val();
			var sizeunit = $(this).find("#sizeunit").val();
			
			if( isNaN(size) || size <= 0 || (parseInt(size)-parseFloat(size)!=0?true:false) ) {
				console.log("error!");
				err = err + 1;
				sizeErr ++;
			} else {
				datafile += " '" + filename + ".dbf' size " + size + sizeunit + ","
			}
		});
		if(sizeErr > 0)
			$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
		
		datafile = datafile.substring(0, datafile.length-1); // 맨 마지막 , 제거
		// 데이터파일 입력한 값을 '데이터파일명.dbf' size 0m, ... 로 양식에 맞게 만들어 datafile의 값에 저장
		
		var sql = "create tablespace " + tsname + " datafile " + datafile
				+ " LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO";
		$("#sql").val(sql);
		
		if (err == 0 && submitCheck == 0) {
			$("#trCreOk").attr("disabled", true)
						  .html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
			console.log("submit!");
			submitCheck = 1;
			console.log(submitCheck);
			$("#tsCreFrm").submit();
		}
	}
	
	// 데이터파일 추가
	function add(){
		var $filename = $("<input>").attr("type","text").attr("id","filename").attr("required",true).attr("class", "form-control-plaintext").attr("readonly", true); // 이름 입력칸
		var $size = $("<input>").attr("type","text").attr("id","size").attr("required",true).addClass("yj_size form-control"); // 용량 입력칸
		var $sizeunit = $("<select>").attr("id","sizeunit").attr("class", "form-control yj_size")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB")); // 용량 단위
		var $btn = $("<input>").attr("type","button").attr("id","delbtn").val("삭제")
								.click(function(){
												$(this).parent().parent().remove();
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
		var name = $("#tablespaceName").val();
		name = name.toUpperCase();
		$("#tablespaceName").val(name);
		$("#tablespaceName").addClass("is-invalid");
			
		// 아이디를 입력하지 않은 경우
		if(name == '') { 
			$("#nameMsg").show().text("이름을 입력해주세요");
			return 1;
		}
		
		// [윤정1112] 길이 30자 넘지 않게
		if(name.length > 30) {
			$("#nameMsg").show().text("길이는 30자를 넘을 수 없습니다");
			return 1;
		}
		
		// [윤정1101] 이름 첫 글자 영어만
		if(!name.substr(0,1).match(/[A-Z]/)) {
			$("#nameMsg").show().text("이름 첫 글자는 영어만 입력할 수 있습니다");
			return 1;
		}
		
		// [윤정 1101] 이름에 A-Z, 0-9, _ 만 쓸 수 있도록
		var err2 = 0;
		var cnt = name.length;
		for(i = 0; i < cnt; i ++) {
			var chk = name.charAt(i);
			if (!chk.match(/[0-9]/) && !chk.match(/[A-Z]/) && chk != '_'){
				err2 = err2 + 1;
			}
			if(err2 > 0) {
				$("#nameMsg").show().text("영어, 숫자, _만 입력할 수 있습니다");
				return 1;
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
				} else { // 중복x
					$("#nameMsg").hide();
					$("#tablespaceName").removeClass("is-invalid");
					$("#tablespaceName").addClass("is-valid");
				}
			}
		}) // ajax
		filenameInput();
	} // tsNameChkFunction
	
	// [윤정1101] 데이터파일명 지정
	function filenameInput(){
		var cnt = 1;
		var name = $("#tablespaceName").val();
		$("#tb1 tbody>tr").each(function(){
			console.log(cnt);
			$(this).find("#filename").val("${sessionScope.member.userId}".toUpperCase() + "_" + name + "_" + cnt);
			cnt++;
		});
	}
	
	// [윤정1108] 종량제 이용량 조회
	function getVolumn(){
		var userId = "${sessionScope.member.userId}";
		var tablespaceName = "${ts.tablespaceName}";
		$.ajax({
			url : "volumn?userId=" + userId + "&tablespaceName=" + tablespaceName,
			type : "GET",
			success : function(data){
				$("#volumn").text((data.volumn));
				freeVolumn = ( service - (data.volumn) ) * 1024; // 단위 MB
				$("#freeVolumn").text(freeVolumn);
				//getThisVolumn();
			},
			error : function(xhr, status, message) {
				alert(" status: " + status + "er:" + message);
			}
		});
	}
	
	// [윤정 1109] 이 테이블스페이스의 용량
	function getThisVolumn(){
		$(".yj_size").change(function(){
			thisVolumn = 0;
			$("#tb1 tbody>tr").each(function(){
				var size = parseInt( $(this).find("#size").val() );
				var unit = $(this).find("#sizeunit").val();
				if(unit == 'G')
					size = size * 1024;
				thisVolumn += size;
				}); // tbody>tr
			$("#thisVolumn").text(thisVolumn);
		}); // yj_size
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<form method = "post" action = "storageCreate" id = "tsCreFrm" target = "main">
	<input type = "hidden" id = "sql" name = "sql">
	<input type = "hidden" name = "userId" value = "${sessionScope.member.userId}">
		<div class ="row">
			<h1>테이블 스페이스</h1>
		</div>
		<div class = "row">
			<label for="tablespaceName" class="col-sm-3 col-form-label">이름</label>
			<div class = "col-9">
				<input type = "text" name = "tablespaceName" id = "tablespaceName" required class = "form-control"> 
				<div class="invalid-feedback" id = "nameMsg"></div>
			</div>
		</div>
		
		<br><br>
		<h1>종량제 정보</h1>
		종량제 이용량 : <span id = "volumn"></span> / ${member.payItem} <br>
		이용가능한 용량 : <span id = "freeVolumn" style = "color:red"></span> MB<br>
		현제 테이블스페이스 용량 : <span id = "thisVolumn" style = "color:red">0</span> MB<br>
		<br><br>
		
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
					<td><input type = "text" id = "filename" required class = "form-control-plaintext" readonly></td>
					<td>
						<div class = "row">
						<div class = "col-9">
							<input type = "text" id = "size" required class = "yj_size form-control">
						</div>
						<div class = "col-3">
						<select id = "sizeunit" class = "yj_size form-control">
							<option value = "M">MB</option>
							<option value = "G">GB</option>
						</select>
						</div>
						</div>
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<div class = "row">
			<button type = "button" id = "trCreOk" class = "btn btn-outline-info btn-block" onclick="formCheck()">생성</button>
			<input type = "button" id="back" value = "목록으로 돌아가기" class = "btn btn-block btn-outline-secondary"
					onclick = 'history.back()'>
		</div>
		
		<div class='yj_error' style='display:none' id="sizeError">용량은 0보다 큰 정수만 입력할 수 있습니다!</div>
		<div class='yj_error' style='display:none' id="tsnameError">테이블스페이스 이름을 입력하세요!</div>
		<div class='yj_error' style='display:none' id="volumnError">이용가능한 용량을 초과했습니다!</div>
	</form>
</div>
</body>
</html>