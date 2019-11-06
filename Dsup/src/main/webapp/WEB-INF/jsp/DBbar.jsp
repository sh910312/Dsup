<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<!-- ↓ DB헬퍼 아이콘 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
</head>
<body>
</body>
	<header>
		<div class="navbar navbar-dark bg-dark box-shadow">
			<div class="container d-flex db-hightlight">
			
				<a href="./main" class="navbar-brand d-flex align-items-center mr-auto bd-hightlight"> 
					<i class="fa fa-database" aria-hidden="true" style="margin-right: 10px"></i>
					<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
					<circle cx="12" cy="13" r="4"></circle></svg> <strong>DBhelper</strong>
				</a>
				
				<a href = "storageList" class = "bd-hightlight navbar-brand">테이블 스페이스</a>
				<a href = "userList" class = "bd-hightlight navbar-brand">유저</a>
				<a href = "backupList" class = "bd-hightlight navbar-brand">백업</a>
				
			</div>
		</div>
	</header>
    
	
<div>
<%@include file="bar.jsp" %>
</div>   	
</html>