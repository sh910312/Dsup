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

	<!-- 토스트 css -->
	<link rel = "stylesheet" href="./resources/css/Toast.css">

	<script>
	var sql = "";
	var oldName = "${ts.tablespaceName}";
	
	$(function(){
		startChk();
		$("#updbtn").click(submit);
		$(".alert").hide();
		tsNameChkFunction();
		$("input:radio").change(statusChk);
		statusSql();
		$("#addbtn").click(trAdd); // 데이터파일 추가 버튼 클릭
		$(".yj_trupd").click(trEdit); // 용량수정
		$(".yj_drop").click(drop); // 데이터파일 삭제
	});
	
	// [윤정 1104] 온라인/오프라인/리드온리 상태 체크
	function startChk(){
		if("${ts.status}" == "READ ONLY")
			$("#readonly").attr("checked", true);
		else
			$("#readwrite").attr("checked", true);
		
		if("${ts.total}" == 0)
			$("#offline").attr("checked", true);
		else
			$("#online").attr("checked", true);
			
		statusChk();
	} // startChk()
	
	// [윤정 1104] 상태에 따라 수정가능한 값 제한
	function statusChk() {
		var status1 = $("input[name='status1']:checked").val(); // online offline
		var status2 = $("input[name='status2']:checked").val(); // read write, read only
		
		if (status1 == "OFFLINE") { // ---- offline
			$("#newName").attr("readonly", true); // 테이블스페이스 이름 수정 불가
			$("#addbtn").attr("disabled", true) // 데이터파일 추가 불가
			$(".yj_trupd").attr("disabled", true) // 데이터파일 수정 불가
			$(".yj_drop").attr("disabled", true) // 데이터파일 삭제 불가
			$("input[name='status2']").attr("disabled", true); // read write, read only 수정 불가
		} else { // ---- online
			$("input[name='status2']").attr("disabled", false); // read write, read only 수정 가능
			$("#newName").attr("readonly", false); // 테이블스페이스 이름 수정 가능
			if(status2 == "READ ONLY") { // ---- read only
				$("#addbtn").attr("disabled", true) // 데이터파일 추가 불가
				$(".yj_trupd").attr("disabled", true) // 데이터파일 수정 불가
				$(".yj_drop").attr("disabled", true) // 데이터파일 삭제 불가
			} else { // ---- read write
				$("#addbtn").attr("disabled", false) // 데이터파일 추가 가능
				$(".yj_trupd").attr("disabled", false) // 데이터파일 수정 가능
				$(".yj_drop").attr("disabled", false) // 데이터파일 삭제 가능
			}
		}
	}
	
	// [윤정 1104] 상태수정 -> sql 추가
	function statusSql() {
		$("input[name='status1']").change(function(){
			sql += "ALTER TABLESPACE " + oldName + " " + $("input[name='status1']:checked").val() + ";";
		});
		$("input[name='status2']").change(function(){
			sql += "ALTER TABLESPACE " + oldName + " " + $("input[name='status2']:checked").val() + ";";
		});
	}
	
	// [윤정 1104] 데이터파일 추가
	function trAdd(){
		var lastName = $("tr:last-of-type").find("td:eq(0)").text();
		var temp = lastName.split("\\");
		lastName = temp[temp.length-1]; // : userId_tablespaceName_numbering.DBF
		
		var temp2 = lastName.split("_"); // _numbering.DBF
		num = temp2[temp2.length-1];
		num = num.split(".DBF")[0];
		num = parseInt(num) + 1; // 다음 데이터파일 넘버

		var fileName = temp2[0] + "_" + temp2[1] + "_" + num + ".DBF";
		// ↑ 파일 이름
		
		var file = "<input type = 'text' id = 'newFilename' readonly value = '" + fileName + "' >";
		var size = "<input type = 'text' id = 'newSize' required>";
		var $sizeunit = $("<select>").attr("id","newSizeunit")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB"))
									.append($("<option>").val("T").text("TB")); // 용량 단위
		var $okbtn = $("<input>").attr("type","button").attr("id","addOk").val("추가완료").click(trAddOk);
		var $canbtn = $("<input>").attr("type","button").attr("id","addCancel").val("취소").click(trAddCan);
		
		// ↓ 테이블에 행 추가
		$("tbody").append($("<tr>").append( $("<td>").html(file) )
									.append( $("<td>").html(size) )
									.append( $("<td>").append($sizeunit) )
									.append( $("<td>").append($okbtn).append($canbtn) )
						)
		
		$("#addbtn").attr("disabled", true); // 행추가 못하게
		$("input:radio").attr("disabled", true); // 상태 변경 금지
	}
	
	// [윤정 1104] 데이터파일 추가 - 취소 버튼 클릭
	function trAddCan(){
		$("tr:last").remove();
		$("#addbtn").attr("disabled", false);
		$("input:radio").attr("disabled", false); // 상태 변경 허용
	}
	
	// [윤정 1104] 데이터파일 추가 - 추가 완료
	function trAddOk(){
		var filename = $("#newFilename").val();
		var size = $("#newSize").val();
		var sizeunit = $("#newSizeunit").val();
		
		// ↓ 용량 제대로 입력했는지 확인
		if(isNaN(size) || size.length == 0) {
			$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
			return;
		}
		
		$("#addbtn").attr("disabled",false); // tr 추가 버튼 활성화
		$("input:radio").attr("disabled", false); // 상태 변경 허용
		
		sql += "ALTER TABLESPACE " + oldName + " ADD DATAFILE '" + filename + "' SIZE " + size + sizeunit + ";";
		// ↓ 테이블 원래 모양대로
		$("tr:last").remove();
		var $tr = $("<tr>").append( $("<td>").text(filename) )
							.append( $("<td>").text(size) )
							.append( $("<td>").text(sizeunit) )
							.append( $("<td>").append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_trupd btn btn-info").click(trEdit) ) 
												.append( $("<input>").attr("type", "button").val("삭제").attr("class", "yj_drop btn btn-info").click(drop) ) 
										);
		$("tbody").append($tr);
	}
	
	// [윤정 1105] 용량수정 버튼 클릭
	function trEdit(){
		$(".yj_trupd").attr("disabled", true); // 다른 행의 '용량수정' 버튼 비활성화
		$("input:radio").attr("disabled", true); // 상태 변경 금지

		var $tr = $(this).closest("tr");
		var oldValue = $tr.find("td:eq(1)").text(); // 기존 용량
		var oldUnit = $tr.find("te:eq(2)").text(); // 기존 용량단위
		
		var $sizeunit = $("<select>").attr("id","sizeunit")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB"))
									.append($("<option>").val("T").text("TB")); // 용량 단위
		// ↓ 테이블 내용 수정
		$tr.find("td:eq(1)").empty()
							.append( $("<input>").attr("type","text").attr("id","size").val(oldValue) );
		$tr.find("td:eq(2)").empty()
							.append( $sizeunit );
		$tr.find("td:eq(3)").empty()
							.append( $("<input>").attr("type","button").attr("id","updOk").val("수정완료") )
							.append( $("<input>").attr("type","button").attr("id","updCancel").val("취소하기") );

		$("#updOk").click(trEditOk); // 수정 완료
		// ↓ 수정 취소
		$("#updCancel").click(function(){
			$tr.find("td:eq(1)").empty().text(oldValue);
			$tr.find("td:eq(2)").empty().text(oldUnit);
			$tr.find("td:eq(3)").empty()
								.append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_trupd btn btn-info").click(trEdit) )
								.append( $("<input>").attr("type", "button").val("삭제").attr("class", "yj_drop btn btn-info").click(drop) );
			
			$(".yj_trupd").attr("disabled", false); // 다른 행의 '용량수정' 버튼 활성화
			$("input:radio").attr("disabled", false); // 상태 변경 금지
			
		});
	}
	
	// [윤정 1105] 용량 수정 완료
	function trEditOk(){
		var $tr = $(this).closest("tr");
		var size = $tr.find("#size").val();
		var sizeunit = $tr.find("#sizeunit").text();
		var filename = $tr.find("#filename").text();
		
		// ↓ 용량 제대로 입력했는지 확인
		if(isNaN(size) || size.length == 0) {
			$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
			return;
		}
		
		$(".yj_trupd").attr("disabled", false); // 다른 행의 '용량수정' 버튼 활성화
		$("input:radio").attr("disabled", true); // 상태 변경 금지
		
		// ↓ 테이블 원래대로
		$tr.find("td:eq(1)").empty().text(size);
		$tr.find("td:eq(2)").empty().text(oldUnit);
		$tr.find("td:eq(3)").empty()
							.append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_trupd btn btn-info").click(trEdit) )
							.append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_drop btn btn-info").click(drop) );
		
		sql += "ALTER DATABASE DATAFILE '" + filename + "' RESIZE " + size + sizeunit + ";";
	}
	
	// [윤정 1104] 수정하기 버튼 클릭
	function submit(){
		
		var newName = $("#newName").val();
		if (newName != oldName) { // 이름 변경 
			sql += "ALTER TABLESPACE " + oldName + " RENAME TO " + newName + ";";
			sql += "UPDATE user_tbspc_tb SET tablespace_name = '" + newName + "' WHERE tablespace_name = '" + oldName + "';";
		}
		
		$("#sql").val(sql);
		$("#frm").submit();
	}
	
	// [윤정 1104] 데이터파일 삭제
	function drop(){
		var $tr = $(this).closest("tr");
		var filename = $tr.find("td:eq(0)").text();
		
		sql += "ALTER TABLESPACE " + oldName + " DROP DATAFILE '" + filename + "';";
		
		$tr.remove();
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
			<input type = "radio" name = "status1" id = "online" value = "ONLINE" class = "form-check-input">
				<label for = "online">online</label>
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status1" id = "offline" value = "OFFLINE" class = "form-check-input">
				<label for = "offline">offline</label>
		</div>
	</div>
	<div class = "row">
		<div class = "col-2"></div>
		<div class = "col-2">
			<input type = "radio" name = "status2" id = "readwrite" value = "READ WRITE" class = "form-check-input">
				<label for = "readwrite">read write</label>
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status2" id = "readonly" value = "READ ONLY" class = "form-check-input">
				<label for = "readonly">read only</label>
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
						<input type = "button" value = "삭제" class = "yj_drop btn btn-info" >
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
<div class='yj_error' style='display:none' id="sizeError">용량은 숫자만 입력할 수 있습니다!</div>
	
	<div class = "row">
		<input type = "button" id = "updbtn" value = "수정하기" class = "btn btn-info">
	</div>
</form>
</div>
</body>
</html>