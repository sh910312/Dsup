<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 이재문 필요한 link 파일들 -->   
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
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js" defer="defer"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap4.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" rel="stylesheet">
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap4.min.css" rel="stylesheet">
<!-- Google Chart-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath }/resources/js/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<%-- <link href="${pageContext.request.contextPath }/resources/js/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet"> --%>

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath }/resources/js/admin/css/sb-admin.css" rel="stylesheet">

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
//volume이랑 user 내용 겹쳐서 volume 안쓰기로 해서 주석처리함
/* function pageChange(type){
	if(type == 'Volume'){
		$('#volume-jsp-div').css('display', 'block');
		$('#user-jsp-div').css('display', 'none');
	}else if(type == 'User'){
		$('#volume-jsp-div').css('display', 'none');
		$('#user-jsp-div').css('display', 'block');
	}
} */
</script>