<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Storage</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script>
	$(function(){
		$("#btn").click(formCheck);
		$("#addbtn").click(add);
		tsNameChkFunction();
		$("#alert").hide();
	});
	
	// 제출 전 확인
	function formCheck(){
		var tsname = $("#tablespaceName").val();
		var datafile = "";
		
		$("tbody>tr").each(function(){
			var filename = $(this).find("#filename").val();
			var size = $(this).find("#size").val();
			var sizeunit = $(this).find("#sizeunit").val();
			
			if(isNaN(size)){
				alert("용량은 숫자만 입력할 수 있습니다!");
				return false;
			}
			
			datafile += " '" +  ${sessionScope.member.userId} + "_" + filename + ".dbf' size " + size + sizeunit + ","
		});
		
		datafile = datafile.substring(0, datafile.length-1); // 맨 마지막 , 제거
		// 데이터파일 입력한 값을 '데이터파일명.dbf' size 0m, ... 로 양식에 맞게 만들어 datafile의 값에 저장
		
		var sql = "create tablespace " + tsname + " datafile " + datafile
				+ " LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO";
		$("#sql").val(sql);
	}
	
	// 데이터파일 추가
	function add(){
		var $filename = $("<input>").attr("type","text").attr("id","filename").attr("required",true); // 이름 입력칸
		var $size = $("<input>").attr("type","text").attr("id","size").attr("required",true); // 용량 입력칸
		var $sizeunit = $("<select>").attr("id","sizeunit")
									.append($("<option>").val("M").text("MB"))
									.append($("<option>").val("K").text("KB"))
									.append($("<option>").val("G").text("GB"))
									.append($("<option>").val("T").text("TB")); // 용량 단위
		var $btn = $("<input>").attr("type","button").attr("id","delbtn").val("삭제")
							.click(function(){	$(this).parent().parent().remove();	}); // 삭제 버튼
		
		var $tr = $("<tr>")
						.append($("<td>").append($filename))
						.append($("<td>").append($size).append($sizeunit))
						.append($("<td>").append($btn)); // 위의 칸들을 하나의 tr로 붙임
		$("#tb1").append($tr); // 테이블에 tr 추가
	}
	
	// [윤정 1031] 테이블스페이스명 유효성 검사 
	function tsNameChkFunction() {
		$("#tablespaceName").blur(function(){
			var name = $("#tablespaceName").val();
			name = name.toUpperCase();
			$("#tablespaceName").val(name);
			
			$.ajax({
				url : "tsNameChk?tablespaceName=" + name,
				type : 'GET',
				success : function(data) {
					// 중복이면 0, 아니면 1
					if(data == 0) { // 중복
						$("#alert").show();
					} else if(name == '') { // 아이디를 입력하지 않은 경우
						$("#alert").show();
					} else { // 중복x
						$("#alert").hide();
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
	<form onsubmit="formCheck()" method = "post" action = "storageCreate">
	<input type = "hidden" id = "sql" name = "sql">
		<h1>테이블 스페이스</h1>
		테이블 스페이스 이름
		<input type = "text" name = "tablespaceName" id = "tablespaceName" required
			class = "form-control"> 
		<br>
		<div class = "alert alert-info" role="alert" id = "alert">사용할 수 없는 이름입니다</div>
		<br>
		
		<h1>데이터 파일</h1>
		<table border = "1" id = "tb1" class = "table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>용량</th>
					<th><input type = "button" id = "addbtn" value = "추가"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type = "text" id = "filename" required class = "form-control"></td>
					<td>
						<input type = "text" id = "size" required class = "form-control">
						<select id = "sizeunit" class = "form-control">
							<option value = "M">MB</option>
							<option value = "K">KB</option>
							<option value = "G">GB</option>
							<option value = "T">TB</option>
						</select>
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<input type = "submit" id="btn" value = "생성">
	</form>
</div>
</body>
</html>