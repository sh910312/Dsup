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
</head>
<body>
	<div>
		<%@include file="bar.jsp"%>
	</div>
	<header>
	<div class="navbar navbar-dark bg-dark box-shadow">
		<div class="container d-flex justify-content-between">
			<a href="#" class="navbar-brand d-flex align-items-center"> 
				<i class="fa fa-database" aria-hidden="true" style="margin-right: 10px"></i>
				<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
				<circle cx="12" cy="13" r="4"></circle></svg> <strong>DBhelper</strong>
			</a>
			<div class="dropdown">
			  	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  		<span class="navbar-toggler-icon"></span>
			  	</button>
			  	<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
			    	<button class="dropdown-item" type="button">Action</button>
			    	<button class="dropdown-item" type="button">Another action</button>
			    	<button class="dropdown-item" type="button">Something else here</button>
			  	</div>
			</div>
		</div>
	</div>
	</header>
	<main role="main">
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row">
					<div class="main-menu col-md-4" onclick="location.href='./sqlIndex'">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="SQL [100%x225]"
								style="height: 225px; width: 100%; display: block;"
								src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22348%22%20height%3D%22226%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20348%20226%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16e33c4645c%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A17pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16e33c4645c%22%3E%3Crect%20width%3D%22348%22%20height%3D%22226%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22116.7109375%22%20y%3D%22120.6875%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
								data-holder-rendered="true">
							<div class="card-body">
								<p class="card-text">SQL 작성을 아이콘을 이용하여 보다 손쉽게 사용자들이 원하는 데이터를 얻을 수 있도록 합니다.</p>
							</div>
						</div>
					</div>
					<div class="main-menu col-md-4" onclick="location.href='./dbIndex'">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="DBmanagement [100%x225]"
								src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22348%22%20height%3D%22226%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20348%20226%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16e33c4645e%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A17pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16e33c4645e%22%3E%3Crect%20width%3D%22348%22%20height%3D%22226%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22116.7109375%22%20y%3D%22120.6875%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
								data-holder-rendered="true"
								style="height: 225px; width: 100%; display: block;">
							<div class="card-body">
								<p class="card-text">신청한 종량제 데이터베이스의 스키마, 테이블스페이스, 백업까지 관리하실 수 있습니다.</p>
							</div>
						</div>
					</div>
					<div class="main-menu col-md-4" onclick="location.href='./serviceSchemaList'">
						<div class="card mb-4 box-shadow">
							<img class="card-img-top"
								data-src="holder.js/100px225?theme=thumb&amp;bg=55595c&amp;fg=eceeef&amp;text=Thumbnail"
								alt="Data Measured Rate System [100%x225]"
								src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22348%22%20height%3D%22226%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20348%20226%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16e33c46460%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A17pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16e33c46460%22%3E%3Crect%20width%3D%22348%22%20height%3D%22226%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22116.7109375%22%20y%3D%22120.6875%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
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
				</div>
			</div>
		</div>
	</main>
</body>
</html>