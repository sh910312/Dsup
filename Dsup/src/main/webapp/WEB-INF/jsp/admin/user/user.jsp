<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src = "https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
	
</script>
<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">User</a></li>
		<li class="breadcrumb-item active">#</li>
	</ol>

	<!-- Icon Cards-->
	<div class="row">
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-primary o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fas fa-fw fa-users"></i>
					</div>
					<div class="mr-5">사용자 관리</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#"
				 onclick = "userPageChange('userManagement')">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fas fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-warning o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fas fa-fw fa-cubes"></i>
					</div>
					<div class="mr-5">테이블 스페이스</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#"
				 onclick = "userPageChange('userTablespace')">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fas fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-danger o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fas fa-fw fa-id-card"></i>
					</div>
					<div class="mr-5">유저 스키마</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#"
				 onclick = "userPageChange('userSchema')">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fas fa-angle-right"></i>
				</span>
				</a>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-success o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fas fa-fw fa-shopping-cart"></i>
					</div>
					<div class="mr-5">결제 이력</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#"
				 onclick = "userPageChange('payHistory')">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fas fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-info o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fas fa-fw fa-copy"></i>
					</div>
					<div class="mr-5">백업</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#"
				 onclick = "userPageChange('userBackup')">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fas fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
	</div>
	
	<!-- DataTables 들어올 자리 -->
	<div id = "datatableContent">
		<div id = "userManagement" class="yj_user" style="display:block">
			<jsp:include page="userManagement.jsp"></jsp:include>
		</div>
		<div id = "payHistory" class="yj_user" style="display:none">
			<jsp:include page="payHistory.jsp"></jsp:include>
		</div>
		<div id = "userTablespace" class="yj_user" style="display:none">
			<jsp:include page="userTablespace.jsp"></jsp:include>
		</div>
		<div id = "userSchema" class="yj_user" style="display:none">
			<jsp:include page="userSchema.jsp"></jsp:include>
		</div>
		<div id = "userBackup" class="yj_user" style="display:none">
			<jsp:include page="userBackup.jsp"></jsp:include>
		</div>
	</div>
</div>