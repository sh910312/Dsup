<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src = "https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
	
</script>
<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">관리자 메뉴</a></li>
		<li class="breadcrumb-item active">사용자 관리</li>
	</ol>
	
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