<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Storage</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<script>
	$(function(){
		usedPercent();
	})
	
	// [윤정 1105] 사용량 퍼센트 
	function usedPercent(){
		var percent = ${ts.used} / ${ts.total} * 100;
		$(".progress").html(
						'<div class="progress-bar" role="progressbar" style="width: ' + percent + '%;" aria-valuenow="' + percent  +'" aria-valuemin="0" aria-valuemax="100">' + percent + '%</div>'		
					);
	}
	</script>
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<h1>테이블 스페이스</h1>
	이름 : ${ts.tablespaceName} <br>
	상태 : ${ts.status} <br>
	전체 용량 : ${ts.total}MB <br>
	사용량 : ${ts.used}MB <br>
	빈 용량 : ${ts.free}MB <br>
	<div class="progress" style="height: 20px;">
	</div>
	
	<h1>데이터 파일</h1>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>파일 이름</th>
				<th>전체 용량</th>
				<th>사용량</th>
				<th>빈 용량</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${df}" var="df">
				<tr>
					<td>${df.fileName}</td>
					<td>${df.total}</td>
					<td>${df.used}</td>
					<td>${df.free}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class ="row">
		<input type = "button" value = "수정" id = "updgo" class = "btn btn-outline-info btn-block" onclick = "location.href='./storageUpdateForm?tablespaceName=${ts.tablespaceName}'">
		<input type = "button" value = "뒤로가기" class = "btn btn-outline-secondary btn-block" onclick = "window.history.back()">	
	</div>
</div>
</body>
</html>