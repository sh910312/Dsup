<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Update Storage</title>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<script>
	var sql = "";
	var oldName = "${ts.tablespaceName}";
	
	$(function(){
		startChk();
		$("#updbtn").click(submit);
		$("#alert").hide();
		tsNameChkFunction();
	});
	
	// [윤정 1104] 온라인/오프라인/리드온리 상태 체크
	function startChk(){
		switch("${ts.getStatus()}") {
		case "ONLINE":
			$("#online").attr("checked", true);
			break;
		case "OFFLINE":
			$("#offline").attr("checked", true);
			break;
		case "READ ONLY":
			$("#readonly").attr("checked", true);
		}
		
		
		var status = $("input[name='status']:checked").val();
		if(status == "offline normal") { // 오프라인 : 테이블스페이스 이름 수정 불가
			console.log("오프라인");
			$("#newName").attr("readonly", true);
		} else if (status == "read only") { // 오프라인, 리드온리 : 새로운 데이터파일 추가 불가
			console.log("리드 온리");
		} else {
			console.log("온라인");
			$("#newName").attr("readonly", false);
		}
	} // startChk()
	
	// [윤정 1104] 상태에 따라 수정가능한 값 제한
	function statusChk(){
		
	}
	
	
	// [윤정 1104] 수정하기 버튼 클릭
	function submit(){
		
		var newName = $("#newName").val();
		sql += "ALTER TABLESPACE " + oldName + " RENAME TO " + newName + ";";
		sql += "UPDATE user_tbspc_tb SET tablespace_name = '" + newName + "' WHERE tablespace_name = '" + oldName + "';";
		// 이름 변경 
		
		var status = $("input[name='status']:checked").val();
		if("${ts.getStatus()}" == "OFFLINE")
			sql += "ALTER TABLESPACE " + newName + " online;";
			// 오프라인 상태였다면, 먼저 온라인 상태로 바꾼다 (그래야 read only상태로 수정 가능)
		sql += "ALTER TABLESPACE " + newName + " " + status + ";";
		// 상태 변경 (상태 변하든 안변하든 실행)
		
		$("#sql").val(sql);
		$("#frm").submit();
	}
	
	// [윤정 1031] 테이블스페이스명 유효성 검사 
	function tsNameChkFunction() {
		$("#newName").blur(function(){
			var name = $("#newName").val().toUpperCase();
			$("#newName").val(name);
			
			// [윤정 1104] 기존의 네임과 같은 경우
			if(name == oldName) {
				$("#alert").hide();
				$("#updbtn").attr("disabled", false);
				return;
			}
			
			// 아이디를 입력하지 않은 경우
			if(name == '') { 
				$("#alert").show().text("이름을 입력해주세요");
				$("#updbtn").attr("disabled", true);
				return;
			}
			
			// [윤정1101] 이름 첫 글자 영어만
			if(!name.substr(0,1).match(/[A-Z]/)) {
				$("#alert").show().text("이름 첫 글자는 영어만 입력할 수 있습니다");
				$("#updbtn").attr("disabled", true);
				return;
			}
			
			// [윤정 1101] 이름에 A-Z, 0-9, _ 만 쓸 수 있도록
			var err = 0;
			var cnt = name.length;
			for(i = 0; i < cnt; i ++) {
				var chk = name.substr(i, i+1);
				if (!chk.match(/[0-9]/) && !chk.match(/[A-Z]/) && chk != '_'){
					err = err + 1;
				}
				if(err > 0) {
					$("#alert").show().text("영어, 숫자, _만 입력할 수 있습니다");
					$("#updbtn").attr("disabled", true);
					return;
				}
			}
		
			$.ajax({
				url : "tsNameChk?tablespaceName=" + name,
				type : 'GET',
				success : function(data) {
					// 중복이면 0, 아니면 1
					if(data == 0) { // 중복
						$("#alert").show().text("사용할 수 없는 이름입니다");
						$("#updbtn").attr("disabled", true);
					} else { // 중복x
						$("#alert").hide();
						$("#updbtn").attr("disabled", false);
					}
				}
			}) // ajax
		}); // .blur(function)
	} // tsNameChkFunction
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
<form id = "frm" method = "post" action = "sotrageUpdate">
	<input type = "hidden" id = "oldName" name = "oldName" value = "${ts.tablespaceName}">
	<input type = "hidden" id = "sql" name = "sql">
	<div class = "row">
		<h1>테이블 스페이스</h1>
	</div>
	<div class = "row">
		<div class = "col-2">
			이름
		</div>
		<div class = "col-10">
			<input type = "text" value = "${ts.tablespaceName}" class = "form-control" name = "newName" id = "newName">
		</div>
	</div>
	<div class = "alert alert-info" role="alert" id = "alert"></div>
	<div class = "row">
		<div class = "col-2">
			상태
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status" id = "online" value = "read write" class = "form-check-input">
				<label for = "online">read write</label>
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status" id = "readonly" value = "read only" class = "form-check-input">
				<label for = "readonly">read only</label>
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status" id = "offline" value = "offline normal" class = "form-check-input">
				<label for = "offline">offline</label>
		</div>
	</div>
	<div class = "row">
		<div class = "col">
			전체 용량
		</div>
		<div class = "col">
			${ts.total}
		</div>
	</div>
	<div class = "row">
		<div class = "col">
			사용량
		</div>
		<div class = "col">
			${ts.used}
		</div>
	</div>
	<div class = "row">
		<div class = "col">
			빈 용량
		</div>
		<div class = "col">
			${ts.free}
		</div>
	</div>
	
	<br><br><br>
	
	<div class = "row">
		<div class = "col">
			<h1>데이터파일</h1>
		</div>
		<div class = "col">
			<input type = "button" id = "addbtn"
					class = "btn btn-info" value = "추가">
		</div>
	</div>
	<div class = "row">
		<table class = "table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>용량</th>
					<th>용량 단위</th>
					<th>버튼</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${df}" var = "df">
				<tr>
					<td id = "filename">${df.fileName}</td>
					<td id = "sizetd">${df.total}</td>
					<td>M</td>
					<td id = "btntd">
						<input type = "button" value = "용량수정" class = "yj_trupd btn btn-info" >
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class = "row">
		<input type = "button" id = "updbtn" value = "수정하기" class = "btn btn-info">
	</div>
</form>
</div>
</body>
</html>