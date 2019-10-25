<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.css">
<link rel="stylesheet" href="./resources/css/custom.css">
<script src="./resources/js/sockjs.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
</head>
<body>
<div class="container">
	<div>
		<div class="row">
			<div class="col-xs-13">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h3>
								<i class="fa fa-circle text-green"></i>D-sup 검색하기
							</h3>
						</div>
						<div class="clearfix">
						</div>
					</div>
						<!-- 대화입력창  -->
					<div class="portlet-footer">
						<div class="row" >
							<div class="form-group col-xs-10">
								<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="검색할 내용을 입력하세요." maxlength="20">
							</div>
							
							<form action="insertSearch" method="post" enctype="multipart/form-data">
							<button type="button" class="btn btn-default" name="title" style="height:40px; width:100px;" onclick="#">검&nbsp;&nbsp;색</button>
							</form>
						
						</div>
						<div class="row">
							<div id="text" class="form-group col-xs-12"> <!-- 검색 완료 후 결과보이게 조건 추가  -->
								<textarea style="height: 150px;" id="chatContent" class="form-control" placeholder="검색결과" maxlength="100"></textarea>
							</div>
						</div>
						<div align="center"> <!-- 검색 완료시 (등록/수정) 버튼이 보이게 조건 추가.   -->
 							<!-- <button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="javascript:openButton(0);">등&nbsp;&nbsp;록</button>
							<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="javascript:openButton(1);">수&nbsp;&nbsp;정</button> -->
							<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="self.close();">닫&nbsp;&nbsp;기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>