<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="container-fluid">
	<h6>Administrator Page</h6>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">Volume</a></li>
		<li class="breadcrumb-item active">#</li>
	</ol>
	<h6>Volume Condition Menu</h6>
	<div>
		<jsp:include page="conditionMenu.jsp"></jsp:include>
	</div>

	<h6>Current Volume Condition</h6>
	<div>
		<jsp:include page="currentVolumeCondition.jsp"></jsp:include>
	</div>

	<!-- <h6>DataTables Example</h6> -->
	<div>
		<jsp:include page="datatable.jsp"></jsp:include>
	</div>
</div>