<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="bar.jsp" %>
<script>
	$("#DBbar").html(
		'<li class="nav-item active">'
		+ '<a class="nav-link" href="storageList">테이블 스페이스 <span class="sr-only">(current)</span></a>'
		+ '</li>'
		+ '<li class="nav-item active">'
		+ '<a class="nav-link" href="userList">스키마 관리 <span class="sr-only">(current)</span></a>'
		+ '</li>'
		+ '<li class="nav-item active">'
		+ '<a class="nav-link" href="backupList">백업 관리<span class="sr-only">(current)</span></a>'
		+ '</li>'
	);
</script>
	<div style = "margin-bottom: 60px "></div>
