<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBhelper</title>
<meta name="description" content="Drag a link to reconnect it. Nodes have custom Adornments for selection, resizing, and rotating.  The Palette includes links." />
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<jsp:include page="sql_index_include.jsp"></jsp:include>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">DBhelper</a>
</nav>
<div class="container-fluid">
	<div class="row">
	    <nav class="col-md-2 d-none d-md-block bg-light sidebar">
    		<div class="sidebar-sticky">
	        	<div>
				<div id="start-setting-bar">
					<jsp:include page="setting/startsetview.jsp"></jsp:include>
				</div>
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
       	 	</div>
	    </nav>
    	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-2">
    		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-2 mb-2 mt-2 border-bottom" style="border:groove;">
        		<div id="myPaletteDiv" class="form-control form-control-dark w-100" style="height:60px; border:none"></div>
      		</div>
      		<div style="width: 100%; display: flex; justify-content: space-between">
      			<!-- <div id="myPaletteDiv" style="width: 105px; margin-right: 2px; background-color: whitesmoke; border: groove"></div> -->
				<div id="myDiagramDiv" style="flex-grow: 1; height: 620px; border: groove""></div>
			</div>
   	 	</main>
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
       












	<%-- <div id="full_screen" class="row" style="margin:0px;">
		<div class="col-md-12" style="padding: 0px; border:ridge 2px;"></div>
		<div id="main-contents" class="col-md-10" style="padding: 0px; border:ridge 2px;">
			<div style="width: 100%; display: flex; justify-content: space-between">
				<div id="myPaletteDiv" style="width: 105px; margin-right: 2px; background-color: whitesmoke; border: groove"></div>
				<div id="myDiagramDiv" style="flex-grow: 1; height: 620px; border: groove""></div>
			</div>
		</div>
		<div id="sub-contents" class="col-md-2" style="padding: 0px; border:ridge 2px">
			<div>
				<div id="start-setting-bar">
					<jsp:include page="setting/startsetview.jsp"></jsp:include>
				</div>
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
	</div> --%>
</body>
</html>