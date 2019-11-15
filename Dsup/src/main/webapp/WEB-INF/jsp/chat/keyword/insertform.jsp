<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<script>

$(function() {

	insert();
	back();

});

function insert() {
	
	$("#insertbtn").click(function() {
		
		$("#frm").attr("action", "insertSearch");
		$("#frm").attr("method", "post")
		$("#frm").submit();
	})
} 


function back() {
	
	$("#backbtn").click(function() {
		$("#frm").attr("action", "SearchMap");
		$("#frm").submit();
	})
} 



</script>




<div class="container">
		<div>
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>D-sup 등록하기
								</h3>
							</div>
							<div class="clearfix">
							</div>
						</div>
							<!-- 대화입력창  -->
							<form id="frm">
							<div class="portlet-footer">
								<div class="row" >
									<div class="form-group col-xs-10">
										<input id="title" name="title" class="form-control" placeholder="등록할 키워드를 입력하세요. 15자 이내로 작성하세요." maxlength="15">
									</div>
								</div>
								<div class="row">
									<div id="text" class="form-group col-xs-12">
										<textarea style="height: 150px;" id="contents" name="contents" class="form-control" placeholder="등록할 내용"></textarea>
									</div>
								</div>
								<div align="center">
									<button type="button" id="insertbtn" name="insertbtn" class="btn btn-default" style="height:40px; width:100px;">등&nbsp;&nbsp;록</button>
									<button type="button" id="backbtn" name="backbtn" class="btn btn-default" style="height:40px; width:100px;">돌아가기</button>
								</div>
							</div>
							</form>
					</div>
				</div>
			</div>
		</div>
		<div class="alert alert-success" id="successMessage" style="display: none;">
			<strong>검색 등록에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage" style="display: none;">
			<strong>등록제목과 내용을 모두 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage" style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>


<!-- <form action="insertSearch" method="post">
	제목<input name="title">
	내용<input name="contents">
	<button>등록</button>
</form> 
 -->



</body>
</html>