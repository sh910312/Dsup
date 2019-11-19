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
	// [윤정1109] 종량제
	var service = "${member.payItem}".split("GB")[0];
	var freeVolumn = 0;
	var thisVolumn = 0;
	
	$(function(){
		startChk();
		$("#updbtn").click(submit);
		$("input:radio").change(statusChk);
		statusSql();
		$("#addbtn").click(trAdd); // 데이터파일 추가 버튼 클릭
		$(".yj_trupd").click(trEdit); // 용량수정
		$("#nameMsg").hide(); // 이름 유효성검사 경고 메시지
		getVolumn(); // 이용가능한 용량 조회
	});
	
	// [윤정 1104] 온라인/오프라인/리드온리 상태 체크
	function startChk(){
		if("${ts.status}" == "READ ONLY")
			$("#readonly").attr("checked", true);
		else
			$("#readwrite").attr("checked", true);
		
		statusChk();
	} // startChk()
	
	// [윤정 1104] 상태에 따라 수정가능한 값 제한
	function statusChk() {
		var status2 = $("input[name='status2']:checked").val(); // read write, read only
		
		if(status2 == "READ ONLY") { // ---- read only
			$("#addbtn").attr("disabled", true) // 데이터파일 추가 불가
			$(".yj_trupd").attr("disabled", true) // 데이터파일 수정 불가
		} else { // ---- read write
			$("#addbtn").attr("disabled", false) // 데이터파일 추가 가능
			$(".yj_trupd").attr("disabled", false) // 데이터파일 수정 가능
		}
	}
	
	// [윤정 1104] 상태수정 -> sql 추가
	function statusSql() {
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
		
		var file = "<input type = 'text' id = 'newFilename' readonly value = '" + fileName + "' class='form-control-plaintext'>";
		var size = "<input type = 'text' id = 'newSize' required class = 'form-control'>";
		var $sizeunit = $("<select>").attr("id","newSizeunit").addClass("form-control")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB")); // 용량 단위
		var $okbtn = $("<input>").attr("type","button").attr("id","addOk").val("추가완료").click(trAddOk).addClass("btn btn-outline-info");
		var $canbtn = $("<input>").attr("type","button").attr("id","addCancel").val("취소").click(trAddCan).addClass("btn btn-outline-secondary");
		
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
		if( isNaN(size) || size <= 0 || (parseInt(size)-parseFloat(size)!=0?true:false) ) {
			$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
		} else {
			$("#addbtn").attr("disabled",false); // tr 추가 버튼 활성화
			$("input:radio").attr("disabled", false); // 상태 변경 허용
		
			sql += "ALTER TABLESPACE " + oldName + " ADD DATAFILE '" + filename + "' SIZE " + size + sizeunit + ";";
			// ↓ 테이블 원래 모양대로
			$("tr:last").remove();
			var $tr = $("<tr>").append( $("<td>").text(filename) )
								.append( $("<td>").text(size) )
								.append( $("<td>").text(sizeunit) )
								.append( $("<td>").append( $("<input>").attr("type", "button").val("용량수정").addClass("yj_trupd btn btn-outline-info").click(trEdit) ) 
											);
			$("tbody").append($tr);
			getThisVolumn();
		}
	}
	
	// [윤정 1105] 용량수정 버튼 클릭
	function trEdit(){
		$(".yj_trupd").attr("disabled", true); // 다른 행의 '용량수정' 버튼 비활성화
		$("input:radio").attr("disabled", true); // 상태 변경 금지

		var $tr = $(this).closest("tr");
		var oldValue = $tr.find("td:eq(1)").text(); // 기존 용량
		var oldUnit = $tr.find("td:eq(2)").text(); // 기존 용량단위
		
		var $sizeunit = $("<select>").attr("id","sizeunit").addClass("form-control")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("G").text("GB")); // 용량 단위
		// ↓ 테이블 내용 수정
		$tr.find("td:eq(1)").empty()
							.append( $("<input>").attr("type","text").attr("id","size").val(oldValue).addClass("form-control") );
		$tr.find("td:eq(2)").empty()
							.append( $sizeunit );
		$tr.find("td:eq(3)").empty()
							.append( $("<input>").attr("type","button").attr("id","updOk").val("수정완료").addClass("btn btn-outline-info") )
							.append( $("<input>").attr("type","button").attr("id","updCancel").val("취소").addClass("btn btn-outline-secondary") );

		$("#updOk").click(trEditOk); // 수정 완료
		// ↓ 수정 취소
		$("#updCancel").click(function(){
			$tr.find("td:eq(1)").empty().text(oldValue);
			$tr.find("td:eq(2)").empty().text(oldUnit);
			$tr.find("td:eq(3)").empty()
								.append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_trupd btn btn-outline-info").click(trEdit) );
			
			$(".yj_trupd").attr("disabled", false); // 다른 행의 '용량수정' 버튼 활성화
			$("input:radio").attr("disabled", false); // 상태 변경 금지
			
		});
	}
	
	// [윤정 1105] 용량 수정 완료
	function trEditOk(){
		var $tr = $(this).closest("tr");
		var size = $tr.find("#size").val();
		var sizeunit = $tr.find("#sizeunit").val();
		var filename = $tr.find("td:eq(0)").text();
		
		// ↓ 용량 제대로 입력했는지 확인
		if( isNaN(size) || size <= 0 || (parseInt(size)-parseFloat(size)!=0?true:false) ) {
			$('#sizeError').fadeIn(400).delay(1000).fadeOut(400);
		} else {
			$(".yj_trupd").attr("disabled", false); // 다른 행의 '용량수정' 버튼 활성화
			$("input:radio").attr("disabled", false); // 상태 변경 허용
		
			// ↓ 테이블 원래대로
			$tr.find("td:eq(1)").empty().text(size);
			$tr.find("td:eq(2)").empty().text(sizeunit);
			$tr.find("td:eq(3)").empty()
								.append( $("<input>").attr("type", "button").val("용량수정").attr("class", "yj_trupd btn btn-outline-info").click(trEdit) );
		
			sql += "ALTER DATABASE DATAFILE '" + filename + "' RESIZE " + size + sizeunit + ";";
			getThisVolumn();
		}
	}
	
	// [윤정 1104] 수정하기 버튼 클릭
	function submit(){
		var err = 0;
		
		if(thisVolumn > freeVolumn) {
			$('#volumnError').fadeIn(400).delay(1000).fadeOut(400);
			err += 1;
		}
		console.log(err);
		if (err == 0) {			
			$("#sql").val(sql);
			$("#frm").submit();
		}
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
				getThisVolumn();
			},
			error : function(xhr, status, message) {
				alert(" status: " + status + "er:" + message);
			}
		});
	}
	
	// [윤정 1109] 이 테이블스페이스의 용량
	function getThisVolumn(){
		thisVolumn = 0;
		$("tbody>tr").each(function(){
			var size = parseInt($(this).find("td:eq(1)").text());
			var unit = $(this).find("td:eq(2)").text();
			if(unit == 'G')
				size = size * 1024;
			thisVolumn += size;
			});
		$("#thisVolumn").text(thisVolumn);
	}
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
			<input type = "text" value = "${ts.tablespaceName}" class = "form-control" name = "newName" id = "newName" readonly>
			<div class="invalid-feedback" id = "nameMsg"></div>
		</div>
	</div>
	
	<div class = "row">
		<div class = "col-2">
			상태
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status2" id = "readwrite" value = "READ WRITE" class = "form-check-input">
				<label for = "readwrite">read write</label>
		</div>
		<div class = "col-2">
			<input type = "radio" name = "status2" id = "readonly" value = "READ ONLY" class = "form-check-input">
				<label for = "readonly">read only</label>
		</div>
	</div>
	
	<div class = "row">
		<div class = "col-2">안내사항</div>
		<div class = "col-10">
			read only 상태에서는 데이터파일 수정 및 추가가 불가능합니다.<br>
		</div>
	</div>
	
	<br><br>
	
	<h1>종량제 정보</h1>
	종량제 이용량 : <span id = "volumn"></span> / ${member.payItem} <br>
	이용가능한 용량 : <span id = "freeVolumn"></span> MB<br>
	현제 테이블스페이스 용량 : <span id = "thisVolumn"></span> MB<br>
	
	<br><br>
	
	<div class = "row">
		<div class = "col">
			<h1>데이터파일</h1>
		</div>
		<div class = "col-1 pull-right">
			<input type = "button" id = "addbtn" class = "btn btn-outline-info" value = "추가"
					 data-toggle="tooltip" data-placement="top" title="한번 만든 데이터파일은 삭제할 수 없습니다. 신중하게 만들어주세요!">
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
						<input type = "button" value = "용량수정" class = "yj_trupd btn btn-outline-info" >
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
<div class='yj_error' style='display:none' id="sizeError">용량은 0보다 큰 정수만 입력할 수 있습니다!</div>
<div class='yj_error' style='display:none' id="volumnError">이용가능한 용량을 초과했습니다!</div>
	
	<div class="alert alert-warning alert-dismissible fade show" role="alert">
		↓ 수정완료 버튼을 눌러야 수정한 항목이 반영됩니다.
		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	
	<div class = "row">
		<input type = "button" id = "updbtn" value = "수정 완료" class = "btn btn-outline-info btn-block">
		<input type = "button" id="back" value = "목록으로 돌아가기" class = "btn btn-outline-secondary btn-block"
				onclick = "location.href='./storageList'">
	
	</div>
</form>
</div>
</body>
</html>