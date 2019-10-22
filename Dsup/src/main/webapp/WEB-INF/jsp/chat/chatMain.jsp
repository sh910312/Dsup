<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, inittal-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>채팅창 메인화면</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	
<!-- <script type="text/javascript">

	/* 마지막 시간대 수정  */
	var lastTime = 0; 
/* 	var lastNo = 0; */
 	
 	// 내용 알림말 표시 function
 	function submitFuntion() {
 		var nickname = $('#nickname').val();
		var Contents = $('#Contents').val();
		$.ajax({
			type: "POST",
			url: "./chatSubmitSerlvert",
			data: {
				nickname: encodeURIComponent(nickname),
				Contents: encodeURIComponent(Contents)
			},
			success: function(result){
				if(result == 1){
					autoClosingAlert('#successMessage', 2000);
					chatListFunction('today');
				}else if(result == 0){
					autoClosingAlert('#dangerMessage', 2000);
				}else {
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		
		});
		$('#Contents').val(''); // 데이터 전송을 완료하면 chatContent부분이 초기화 된다.(전송완료되면 내용이 지워짐)
	}
	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide()}, delay);
	}
	
	function chatListFunction(type) {
		$.ajax({
			type: "POST",
			url: "./chatListServlet",
			data: {
				listType: type,
			},
			success: function(data){
				 if(data == "") return; // 파싱 가능한 데이터만 파싱하도록 그외는 리턴(오류처리)
				var parsed = JSON.parse(data);
				var result = parsed.result;
				
				for(var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value, result[i][2].value); // nickname, Contents, write_date 순서대로 출력한다.
				}
				/*  마지막 시간대 */ 
				lastTime = String(parsed.last);
				 alert('마지막 입력 : '+lastTime); 
			}
		});
	}
	
	function openButton(menu){ /*  버튼 새창 */
		
		var popupX = (document.body.offsetWidth / 2) - (100/2);
		var popupY = (document.body.offsetHeight / 2) - (200/2);

		if (menu == 0){
			window.open("report.jsp","신고하기",'width=500px, height=300px, left='+ popupX + ', top='+ popupY);
		}else if (menu == 1){
			window.open("select.jsp","검색하기",'width=600px, height=300px, left='+ popupX + ', top='+ popupY);
		}else if (menu == 2){
			window.open("insert.jsp","등록하기",'width=600px, height=300px, left='+ popupX + ', top='+ popupY);
		}else if (menu == 3){
			window.open("online.jsp","현재접속자",'width=300px, height=500px, left='+ popupX + ', top='+ popupY);
		}else if (menu == 4){
			window.open("loginform.jsp","로그인",'width=500px, height=200px, left='+ popupX + ', top='+ popupY);
		}
	}
	
	
	function addChat(nickname, Contents, write_date){
		$('#chatList').append('<div class="row">' +
				'<div class="col-lg-12">' +
				'<div class="media">' +
				'<a class="pull-left" href="#">' + 
				'<img class="medio-object img-circle" src="images/icon.png" width="50px" height="50px" alt="">' +
				'</a>' +
				'<div class="media-body col-lg-10">' +
				'<h4 class="media-heading">' +
				nickname + 
				'&nbsp;' +
				'<span class="small pull-right">' +
				write_date +
				'<button type="button" class="btn btn-default btn-xs" onclick="javascript:openButton(0);">신고</button>' + 
				'</span>' +
				'</h4>' +
				'<p>' +
				Contents +
				'</p>' +
				'</div>' +
				'</div>' +
				'</div>' +
				'</div>' +
				'<hr>');
		/* 채팅 전송하면 스크롤바 최신상태로 유지  */
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
			
	
   	// 몇초 간격으로 메세지 최신화
 	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction( )
		}, 1000);
	}    
	
	
</script> -->
</head>
<body>
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-7">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>D-sup 실시간 전체채팅
								</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>
									<i class="fa fa-circle text-green"></i>
									<%-- <c:if test="${not empty userid}"> --%> <!-- 변경/등록 버튼은 userid가 있는(관리자/회원)만 볼수있다.  -->
										<!-- <input style="width:100px; height: 40px;" type="text" id="#" class="form-control" placeholder="검색어 입력" maxlength="8"> -->
										<button type="button" class="btn btn-default" onclick="openButton(2);">등록</button>
										<button type="button" class="btn btn-default" onclick="javascript:openButton(1);">검색</button>
									<%-- </c:if> --%>
								</h3>
							</div>
							<div class="clearfix">
							</div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
								<!-- <div class="row">
									<div class="col-lg-12">
										<p class="text-center text-muted small">2019년 10월 10일 목요일</p>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="media">

											회원1 메세지창 
											<a class="pull-left" href="#"> <img
												class="medio-object img-circle" src="images/icon.png"
												width="50px" height="50px">
											</a>
											<div class="media-body">
												<h4 class="media-heading">192.168.0.100 <span class="small pull-right">오전 12:25분</span>
												</h4>
											</div>
											<p>지금 몇시인가요?</p>
											<br>
											회원2 메세지창 
											<a class="pull-left" href="#"> <img
												class="medio-object img-circle" src="images/icon2.jpg"
												width="50px" height="50px">
											</a>
											<div class="media-body">
												<h4 class="media-heading">
													192.168.0.102 <span class="small pull-right">오전
														12:28분</span>
												</h4>
											</div>
											<p>오전 12:28분이요</p>
										</div>
									</div>
								</div> -->
							</div>
							<!-- 대화입력창  -->
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
									<!-- 로그인을 하면 회원아이디로 대체 -->									
									<input style="height: 40px;" type="text" id="nickname" class="form-control" placeholder="이름" maxlength="8">
									</div>
									
									<!-- 회원이면 로그인 버튼은 사라진다 -->
									<c:if test="${empty userid}">
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right" onclick="openButton(4)" style="height:40px; width:100px;">로그인</button>
									</div>									
									</c:if>

									<div class="form-group col-xs-2 pull-right">
										<!-- 현재 접속자 표시  -->
										<button type="button" class="btn btn-default pull-right" onclick="openButton(3)" style="height:40px; width:100px;">현재 접속자</button>
									</div>
								</div>
								<div class="row" style="height: 90px">
									<div id="text" class="form-group col-xs-10">
										<textarea style="height: 80px;" id="Contents" class="form-control" placeholder="메세지를 입력하세요." maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right" style="height:80px; width:100px;"  onclick="submitFuntion();">전&nbsp;&nbsp;송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>

 		<!-- <button type="button" class="btn btn-default pull-right" onclick="chatListFunction('today');">채팅확인</button> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="alert alert-success" id="successMessage" style="display: none;">
			<strong>메세지 전송에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage" style="display: none;">
			<strong>이름과 내용을 모두 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage" style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			chatListFunction('today');
			getInfiniteChat(); 
		});
	</script>
</body>
</html>