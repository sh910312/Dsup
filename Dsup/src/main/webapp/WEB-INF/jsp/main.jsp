<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>DBhelper</title>
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
 <style>
.main-menu {
	cursor: pointer;
	
	
}
</style>
<script>
	function declarationList(){
		$.ajax({
			url : 'DeclarationList',
			type : 'GET',
			dataType : "JSON"
			 
		})
	}
</script>
</head>
<body>




<!-- 메뉴바 시작 -->
<header>
	<div class="navbar navbar-dark bg-dark box-shadow">
		<div class="container d-flex justify-content-between">
			<a href="./main" class="navbar-brand d-flex align-items-center">
				<i class="fa fa-database" aria-hidden="true" style="margin-right: 10px"></i>
				<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
				<circle cx="12" cy="13" r="4"></circle></svg> <strong>DBhelper</strong>
			</a>
			<div class="dropdown">
			  	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  		<span class="navbar-toggler-icon"></span>
			  	</button>
			  	<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
			    	<button class="dropdown-item" type="button">메뉴바1</button>
			    	<button class="dropdown-item" type="button">메뉴바2</button>
			    	<button class="dropdown-item" type="button">메뉴바3</button>
			  	</div>
			</div>
		</div> 
	</div>
</header>
<!-- 메뉴바 끝 -->	
	
<!-- 프로필 바 시작-->	
	<div><%@include file="bar.jsp"%></div>
<!-- 프로필 바 끝-->



	<main role="main">
		<div class="album py-5">  <!-- 수정중 -->
		<!-- <div class="album py-5" style="position:relative; display: inline-block;width: 70%;"> -->  <!-- 대체 -->
			<div class="container"> 
				
				
				
				 <!-- 메인로고 시작점(아래 3가지 div로 감싸는부분)-->
				<div class="row"> 
					
					
					
					
					
					<!-- SQL 부분 시작-->
					<div class="main-menu col-md-4" onclick="location.href='./sqlIndex'">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="SQL [100%x225]"
								style="height: 225px; width: 100%; display: block;"
								src="https://image.flaticon.com/icons/svg/28/28826.svg"
								data-holder-rendered="true">
							<div class="card-body">
								<p class="card-text">SQL 작성을 아이콘을 이용하여 보다 손쉽게 사용자들이 원하는 데이터를 얻을 수 있도록 합니다.</p>
							</div>
						</div>
					</div>
					<!-- SQL 부분 끝-->					
					
					
					
					
					
					<!-- 테이블스페이스 시작-->					
					<div class="main-menu col-md-4" onclick="location.href='./dbIndex'">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="DBmanagement [100%x225]"
								src="https://image.flaticon.com/icons/svg/138/138028.svg"
								data-holder-rendered="true"
								style="height: 225px; width: 100%; display: block;">
							<div class="card-body">
								<p class="card-text">신청한 종량제 데이터베이스의 스키마, 테이블스페이스, 백업까지 관리하실 수 있습니다.</p>
							</div>
						</div>
					</div>
					<!-- 테이블스페이스 끝-->					
					
					
					
					
					
					<!-- 종량제 부분 시작-->					
					<div class="main-menu col-md-4" onclick="disClick()">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="Data Measured Rate System [100%x225]"
								src="https://image.flaticon.com/icons/svg/1423/1423904.svg"
								data-holder-rendered="true"
								style="height: 225px; width: 100%; display: block;">
							<div class="card-body">
								<p class="card-text">사용한 용량 만큼만 비용을 지불하는 종량제 데이터베이스 서비스를 신청하십시오.</p>
<!-- 								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-muted">9 mins</small>
								</div> -->
							</div>
						</div>
					</div>
					<!-- 종량제 부분 끝-->					
					
					
					
					
					
				</div>
				<!-- 메인로고 끝(아래 3가지 div로 감싸는부분)-->
				
				
			</div>
		</div> 
	</main> 
<script type="text/javascript">
function disClick(){
	if("${payService}" == "Y"){
		location.href='./storageList'
	}else{
		location.href='./distributingMain'	
		
	}
}

</script>
</body>
</html>