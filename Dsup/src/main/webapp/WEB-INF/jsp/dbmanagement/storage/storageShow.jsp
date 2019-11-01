<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Storage</title>
	<script src = "https://code.jquery.com/jquery-3.4.1.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%@include file="/WEB-INF/jsp/DBbar.jsp" %>
	<h1>테이블 스페이스</h1>
	이름 : ${ts.tablespaceName} <br>
	상태 : ${ts.status} <br>
	전체 용량 : ${ts.total}MB <br>
	사용량 : ${ts.used}MB <br>
	빈 용량 : ${ts.free}MB <br>	
	
	<h1>데이터 파일</h1>
	
	<table border = "1" class="table">
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
</body>
</html>