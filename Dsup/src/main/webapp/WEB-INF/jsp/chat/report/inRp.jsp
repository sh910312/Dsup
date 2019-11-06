<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- VO 에 date 타입 날짜형식 바꾸기 링크 http://blog.naver.com/PostView.nhn?blogId=lbiryu&logNo=30037958388  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %> 

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
<form id="frm">
	<div class="container">
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>신고하기</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>${search.userId }
									<fmt:formatDate value="${search.writeDate }" pattern="yy-MM-dd" />
								</h3>
							</div>
							<div class="clearfix"></div>
						</div>
						<!-- 대화입력창  -->
						<div class="portlet-footer">
							
							<!-- Search내용 시작 -->
							<div class="row">
								ㅇㅇㅇㅇ
								<br>
									<textarea style="width:100%; height:200px;" id="contents" name="contents" class="form-control" placeholder="신고사유를 작성하세요."></textarea>
								<br>
								<div align="center">
								<br>
							
							<!-- Search내용 끝 -->
								<input type="hidden" name="searchId" value="${search.searchId }" />
									<button type="button" id="updatebtn" name="updatebtn" class="btn btn-default">닫기</button>
									<button type="button" id="backbtn" name="backbtn" class="btn btn-default">돌아가기</button>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>