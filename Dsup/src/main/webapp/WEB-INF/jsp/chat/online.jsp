<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, inittal-scale=1">
<title>실시간접속자</title>
<link rel="stylesheet" href="./resources/css/bootstrap.css">
<link rel="stylesheet" href="./resources/css/custom.css">
<script src="./resources/js/sockjs.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

</head>
<body>

	<div class="container">
		<div class="">
			<div class="row">
				<div class="col-xs-pull">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>현재접속자
								</h3>
							</div>
							<div class="clearfix"></div>
						</div>
						<!-- 대화입력창  -->
						<div class="portlet-footer">
							<div class="row">
								<div class="form-group col-xs-12">
									<input style="height: 400px;" type="text" id="chatName"
									class="form-control" placeholder="" maxlength="20" value="">
										
								</div>
							</div>
							<div align="center">
								<button type="button" class="btn btn-default"
									style="height: 40px; width: 100px;" onclick="self.close();">닫&nbsp;&nbsp;기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>