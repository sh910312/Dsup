<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Administrator Page</title>
<!-- 각종 자바스크립트 및 css 링크 -->
<jsp:include page="scriptLink.jsp"></jsp:include>
<!-- 테이블스페이스, 사용자 관리 메뉴 컨드롤 자바스크립트 -->
<jsp:include page="user/tablespaceTapJavascriptLink.jsp"></jsp:include>
</head>
<body id="page-top">
	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
		<a class="navbar-brand mr-1" href="./main">DBhelper</a>
		<button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search -->
		<!-- 
		<form
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Search for..."
					aria-label="Search" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</form>
		 -->
	</nav>
	
	
	<div id="wrapper">
		<!-- 사이드 메뉴바 -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					onclick = "userPageChange('userManagement')"> 
					<i class="fas fa-fw fa-users"></i> 
					<span>사용자 관리</span>
				</a>
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					onclick = "userPageChange('userTablespace')">
					<i class="fas fa-fw fa-cubes"></i> 
					<span>테이블 스페이스</span>
				</a>
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					onclick = "userPageChange('userSchema')">
					<i class="fas fa-fw fa-id-card"></i> 
					<span>유저 스키마</span>
				</a>
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					onclick = "userPageChange('payHistory')">
					<i class="fas fa-fw fa-shopping-cart"></i> 
					<span>결제 이력</span>
				</a>
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					onclick = "userPageChange('userBackup')">
					<i class="fas fa-fw fa-copy"></i> 
					<span>백업</span>
				</a>
			</li>
		</ul>
	
		<div id="content-wrapper">
			<%-- <div id="volume-jsp-div" style="display:block;">
				<jsp:include page="volume/volume.jsp"></jsp:include>
			</div> --%>
			<div id="user-jsp-div" style="display:block;">
				<!-- 윤정 : 관리 페이지 -->
				<jsp:include page="user/user.jsp"></jsp:include>
			</div>

			<!-- Sticky Footer -->
			<footer class="sticky-footer">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright © Your Website 2019</span>
					</div>
				</div>
			</footer>
		</div>
		
	</div>

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	
	<!-- Bootstrap core JavaScript-->
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Page level plugin JavaScript-->
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/chart.js/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/datatables/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin/vendor/datatables/dataTables.bootstrap4.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${pageContext.request.contextPath }/resources/js/admin/js/sb-admin.min.js"></script>

	<!-- Demo scripts for this page-->
	<script src="${pageContext.request.contextPath }/resources/js/admin/js/demo/datatables-demo.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin/js/demo/chart-area-demo.js"></script>
</body>
</html>