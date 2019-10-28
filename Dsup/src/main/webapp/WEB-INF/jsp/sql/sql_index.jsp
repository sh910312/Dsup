<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBhelper</title>
<meta name="description" content="Drag a link to reconnect it. Nodes have custom Adornments for selection, resizing, and rotating.  The Palette includes links." />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="${pageContext.request.contextPath }/resources/js/sql/go/release/go.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/go/extensions/Figures.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/build.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/controller.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/dto.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/process.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/storage.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/display.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/setting.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/common.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/command.js"></script>
<style>
</style>
</head>
<body>
	<!-- <body onload="build()"> -->
	<div id="full_screen">
		<div id="main-contents">
			<div
				style="width: 100%; display: flex; justify-content: space-between">
				<div id="myPaletteDiv"
					style="width: 105px; margin-right: 2px; background-color: whitesmoke; border: solid 1px black"></div>
				<div id="myDiagramDiv"
					style="flex-grow: 1; height: 620px; border: solid 1px black"></div>
			</div>
		</div>
		<div id="sub-contents" style="display: inline-block;">
			<div style="margin-right : 20px">
				<div id="dbread-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/dbreadsetview.jsp"></jsp:include>
				</div>
				<div id="filter-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/filterview.jsp"></jsp:include>
				</div>
				<div id="join-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/joinsetview.jsp"></jsp:include>
				</div>
				<div id="addition-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/additionview.jsp"></jsp:include>
				</div>
				<div id="order-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/ordersetview.jsp"></jsp:include>
				</div>
				<div id="union-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/unionsetview.jsp"></jsp:include>
				</div>
				<div id="group-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/groupsetview.jsp"></jsp:include>
				</div>
				<div id="rename-setting-bar" style="display: none; border: black solid 1px;">
					<jsp:include page="setting/renamesetview.jsp"></jsp:include>
				</div>
			</div>
			<div id="textarea-container"">
				<div id="state_msg_div" style="width: 100%; color : red; overflow:auto;  width: 100%; height: 300px; border: solid 1px black"">
					<div style="color : black;">
						<div>select * from emp</div>
						<div>select empno as EMPNO_test, ename as ENAME_test, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO from emp</div>
						<div>select * from dept</div>
					</div>
				</div>
				<div id="main-contents-bottom" style="display: none;">
					<div style="display: inline-block;">
						<button id="SaveButton" onclick="controller.save()">Save</button>
						<button onclick="controller.load()">Load</button>
						<div style="display: inline;">
							<div>select * from emp</div>
							<div id="icon-id-span">select * from dept</div>
						</div>
					</div>
				</div>
				<div style="display: none; ">
					 <textarea id="mySavedModel" style="width: 100%; height: 300px;">
	{ "nodeDataArray": [ 
		{"text":"Start", "source":"./resources/images/sql/Start.png", "key":"FIRST"} ],
	  "linkDataArray": [ 
	  
	  ]}
	  				 </textarea>
				</div>
			</div>
		</div>
	</div>
</body>
</html>