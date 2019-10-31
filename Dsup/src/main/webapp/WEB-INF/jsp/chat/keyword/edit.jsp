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

	insertBoard();


});



</script>




<div class="container">
		<div>
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>D-sup 수정하기
								</h3>
							</div>
							<div class="clearfix">
							</div>
						</div>
							<!-- 대화입력창  -->
							<form action="insertSearch" method="post">
							<div class="portlet-footer">
								<div class="row" >
									<div class="form-group col-xs-10">
										<input id="title" name="title" class="form-control" placeholder="등록할 키워드를 입력하세요. 10자 이내로 작성하세요." maxlength="10">
									</div>
								</div>
								<div class="row">
									<div id="text" class="form-group col-xs-12">
										<textarea style="height: 150px;" id="contents" name="contents" class="form-control" placeholder="등록할 내용" maxlength="500"></textarea>
									</div>
								</div>
								<div align="center">
									<button class="btn btn-default" style="height:40px; width:100px;">등&nbsp;&nbsp;록</button>
									<button type="button" class="btn btn-default" style="height:40px; width:100px;" onclick="self.close();">닫&nbsp;&nbsp;기</button>
								</div>
							</div>
							</form>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>