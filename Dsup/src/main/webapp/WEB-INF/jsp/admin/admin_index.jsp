<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath }/resources/js/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="${pageContext.request.contextPath }/resources/js/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath }/resources/js/admin/css/sb-admin.css" rel="stylesheet">
<!-- Google Chart-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style type="text/css">/* Chart.js */
@
keyframes chartjs-render-animation {
	from {opacity: .99
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 1ms
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0
}
a{
	cursor:pointer;
}
</style>
<script>
function pageChange(type){
	if(type == 'Volume'){
		$('#volume-jsp-div').css('display', 'block');
		$('#user-jsp-div').css('display', 'none');
	}else if(type == 'User'){
		$('#volume-jsp-div').css('display', 'none');
		$('#user-jsp-div').css('display', 'block');
	}
}

// ↓ [윤정 1111] user.jsp 에서 쓸거임
function userPageChange(type) {
	$(".yj_user").css("display", "none");
	$("#" + type).css("display", "block");
}
</script>
</head>
<body id="page-top">
	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
		<a class="navbar-brand mr-1" href="./main">DBhelper</a>
		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search -->
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
	</nav>
	<div id="wrapper">
		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
					<i class="fas fa-fw fa-folder"></i> 
					<span>Admin</span>
				</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Main:</h6>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" onclick="pageChange('Volume')">Volume</a> 
					<a class="dropdown-item" onclick="pageChange('User')">User</a>
					<div class="dropdown-divider"></div>
					<h6 class="dropdown-header">Part :</h6>
					<a class="dropdown-item" href="#">Page</a> 
					<a class="dropdown-item" href="#">Page</a>
				</div>
			</li>
		</ul>
		<div id="content-wrapper">
			<div id="volume-jsp-div" style="display:block;">
				<jsp:include page="volume/volume.jsp"></jsp:include>
			</div>
			<div id="user-jsp-div" style="display:none;">
				<jsp:include page="user/user.jsp"></jsp:include>
			</div>
			<!-- /.container-fluid -->

			<!-- Sticky Footer -->
			<footer class="sticky-footer">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright © Your Website 2019</span>
					</div>
				</div>
			</footer>

		</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

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