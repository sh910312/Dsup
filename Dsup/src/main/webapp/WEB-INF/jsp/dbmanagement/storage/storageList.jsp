<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Storage List</title>
	<script src = "https://code.jquery.com/jquery-3.4.1.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script>
	$(document).ready(function(){
		tablespaceList();
		radioCheck();
		
		$("#updbtn").click(function(){
			$("#frm").attr("action", "storageUpdateForm");
			$("#frm").submit();
		});
		// 수정 버튼 클릭
		
		$("#delbtn").click(function(){
			var reply = confirm("삭제하시겠습니까?");
			if (reply == true) { // 확인
				$("#frm").attr("action", "storageDelete");
				$("#frm").submit();
			}
		});
		// 삭제 버튼 클릭
		
		$("#crebtn").click(function(){
			$("#frm").attr("action", "storageCreateForm");
			$("#frm").submit();
		});
		// 생성 버튼 클릭
		
		$("#showbtn").click(function(){
			$("#frm").attr("action", "storageShow");
			$("#frm").submit();
		});
		//조회 버튼 클릭
	});
	
	// [윤정 1030] 테이블스페이스 리스트 조회 요청
	function tablespaceList(){
		$.ajax({
			url: 'getStorage',
			type: 'GET',
			dataType: "json",
			success : tablespaceListResult
		})
	}
	
	// [윤정 1030] 테이블스페이스 리스트 출력
	function tablespaceListResult(list){
		$.each(list, function(idx, item){
			var $radio = $("<td>").html("<input type = 'radio' name = 'tablespaceName' value = '" + (item.tablespaceName) + "'>");
			//var $radio = $("<td>").append( $("<input>").attr("type","radio").val((item.tablespaceName)).attr("name", "tablespaceName") );
			var $tablespaceName = $("<td>").html("<a href = 'storageShow?tablespaceName=" + (item.tablespaceName) + "'>" + (item.tablespaceName) + "</a>");
			var $status = $("<td>").text((item.status));
			var $total = $("<td>").text((item.total));
			var $used = $("<td>").text((item.used));
			var $free = $("<td>").text((item.free));
			
			$("tbody").append($("<tr>").append($radio)
									.append($tablespaceName)
									.append($status)
									.append($total)
									.append($used)
									.append($free)
					);
			$('input:radio[name="tablespaceName"]').eq(0).attr("checked", true);
			// 첫 번째 라디오 자동 체크
		});
	}
	
	// [윤정1031] tr 클릭시 라디오 체크
	function radioCheck(){
		$("tr").each(function(){
			$(this).click(function(){
				console.log("클릭");
				$(this).find("input:radio[name='tablespaceName']").attr("checked", true);
			});
		});
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<form id = "frm" method = "post">
	
	<div class = "row">
		<input id = "updbtn" type = "button" value = "수정"
			class = "btn btn-outline-info">
		<input id = "delbtn" type = "button" value = "삭제"
			class = "btn btn-outline-info">
		<input id = "crebtn" type = "button" value = "생성"
			class = "btn btn-outline-info">
		<input id = "showbtn" type = "button" value = "조회"
			class = "btn btn-outline-info">
	</div>
	
	<hr>
	
	<div class = "row">
	<table class = "table table-bordered table-hover">
		<thead>
		<tr>
			<th></th>
			<th>tablespace name</th>
			<th>status</th>
			<th>total MB</th>
			<th>used MB</th>
			<th>free MB</th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</div>
	
	<div id = "show">
	</div>
	
	</form>
</div>
</body>
</html>