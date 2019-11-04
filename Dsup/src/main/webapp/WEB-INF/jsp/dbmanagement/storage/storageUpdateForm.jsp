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
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
<div class = "container">
	<div class = "row">
		<h1>테이블 스페이스</h1>
	</div>
	<div class = "row">
		이름 <input type = "text" value = "${ts.tablespaceName}">
	</div>
	<div class = "row">
		상태
			<input type = "radio" name = "status" id = "online" value = "read write">
				<label for = "online">read write</label>
			<input type = "radio" name = "status" id = "readonly" value = "read only">
				<label for = "readonly">read only</label>
			<input type = "radio" name = "status" id = "offline" value = "offline normal">
				<label for = "offline">offline</label>
	</div>
	
	<br><br><br>
	
	<div class = "row">
		<h1>데이터파일</h1>
	</div>
	<div class = "row">
		<table class = "table">
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
						<input class = "yj_trupd" type = "button" value = "용량수정">
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class = "row">
		<input type = "button" id = "updbtn" value = "수정">
	</div>
</div>
</body>
</html>