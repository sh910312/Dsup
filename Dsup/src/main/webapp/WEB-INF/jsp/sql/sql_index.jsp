<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String id = "ljm089";
	String schema_id = "scott";
%>
<meta charset="UTF-8">
<title>DBhelper</title>
<meta name="description" content="Drag a link to reconnect it. Nodes have custom Adornments for selection, resizing, and rotating.  The Palette includes links." />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="${pageContext.request.contextPath }/resources/js/sql/go/release/go.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/go/extensions/Figures.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
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
.error { width: auto; height: 20px; height:auto; position: fixed; left: 50%; margin-left:-125px; bottom: 100px; z-index: 9999; background-color: #383838; color: #F0F0F0; font-family: Calibri; font-size: 15px; padding: 10px; text-align:center; border-radius: 2px; -webkit-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); -moz-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); }
</style>
</head>
<body>
	<!-- <body onload="build()"> -->
	<div id="full_screen" class="row" style="margin:0px;">
		<div id="main-contents" class="col-md-10" style="padding: 0px; border:ridge 2px;">
			<div style="width: 100%; display: flex; justify-content: space-between">
				<div id="myPaletteDiv" style="width: 105px; margin-right: 2px; background-color: whitesmoke; border: solid 1px black"></div>
				<div id="myDiagramDiv" style="flex-grow: 1; height: 620px;"></div>
			</div>
		</div>
		<div id="sub-contents" class="col-md-2" style="padding: 0px; border:ridge 2px">
			<div>
				<div id="start-setting-bar"></div>
				<div id="dbread-setting-bar" style="display: none;">
					<jsp:include page="setting/dbreadsetview.jsp"></jsp:include>
				</div>
				<div id="filter-setting-bar" style="display: none;">
					<jsp:include page="setting/filterview.jsp"></jsp:include>
				</div>
				<div id="join-setting-bar" style="display: none;">
					<jsp:include page="setting/joinsetview.jsp"></jsp:include>
				</div>
				<div id="addition-setting-bar" style="display: none;">
					<jsp:include page="setting/additionview.jsp"></jsp:include>
				</div>
				<div id="order-setting-bar" style="display: none;">
					<jsp:include page="setting/ordersetview.jsp"></jsp:include>
				</div>
				<div id="union-setting-bar" style="display: none;">
					<jsp:include page="setting/unionsetview.jsp"></jsp:include>
				</div>
				<div id="group-setting-bar" style="display: none;">
					<jsp:include page="setting/groupsetview.jsp"></jsp:include>
				</div>
				<div id="rename-setting-bar" style="display: none;">
					<jsp:include page="setting/renamesetview.jsp"></jsp:include>
				</div>
				<div id="dbinsert-setting-bar" style="display: none;">
					<jsp:include page="setting/dbinsertsetview.jsp"></jsp:include>
				</div>
			</div>
			<div id="textarea-container"">
				<div class='error' style='display:none'>Error</div>
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