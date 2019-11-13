<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, inittal-scale=1">
<title>채팅창 메인화면</title>
<link rel="stylesheet" href="./resources/css/custom.css">
<script src="./resources/js/sockjs.js"></script>
<!-- 부트스트랩 원래버전 -->
<link rel="stylesheet" href="./resources/css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./resources/js/bootstrap.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<!-- 부트스트랩 수정-->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 -->

<script>

	$(document).ready(function() {
    	$("#sendBtn").click(function() {
 			sendMessage();
 			$('#contents').val('')
		});
         
    	$("#contents").keydown(function(key) {
			if (key.keyCode == 13) { // 엔터zl 13qjs
				sendMessage();
                $('#contents').val('')
			}
		});
	});
    
	// 웹소켓을 지정한 url로 연결한다.
    let sock = new SockJS('<c:url value="/soket"/>');
    sock.onmessage = onMessage;
    sock.onclose = onClose;

    // 메시지 전송
    function sendMessage() {
		sock.send($("#contents").val());
		
	}
    
    // 서버로부터 메시지를 받았을 때
    function onMessage(msg) {
		var data = msg.data;
		$("#chatList").append(data + "&nbsp;"
		+ "<button type='button' class='btn btn-default btn-xs' onclick='openButton(2, this)'>" 
		+ "신고" + "</button>"
		+ "<hr>"
		);
		
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight); // 채팅 최신 상태 유지
	}
    
    // 서버와 연결을 끊었을 때
    function onClose(evt) {
		$("#data").append("연결 끊김");
    }



   
    
</script>

<script>

function openButton(menu, a){ /*  버튼 새창 */
	
	var popupX = (document.body.offsetWidth / 2) - (100/2);
	var popupY = (document.body.offsetHeight / 2) - (200/2);

	if (menu == "0" || menu == 0){
		window.open("SearchMap","검색하기",'width=800px, height=400px, left='+ popupX + ', top='+ popupY);
	}else if(menu == "1" || menu == 1){
		window.open("insertSearchForm","등록하기",'width=800px, height=350px, left='+ popupX + ', top='+ popupY )
	}else if(menu == "2" || menu == 2) {
		console.log(a)
		var id = $(a).prev().children().eq(0).val();
		
		var url = "getRp?chatId="+id;
		var name = "채팅신고";
		var option = 'width=800px, height=300px, left='+ popupX + ', top='+ popupY; 
		window.open(url,name,option);
	}

}
</script>


</head>
<body>
<form id="frm">
	 <!-- <div class="container">  -->
		<!-- <div class="container bootstrap snippet"> -->
			<!-- <div class="row"> -->
				<div class="">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>
									<i class="fa fa-circle text-green"></i>D-sup 실시간 전체채팅 ${chat.chatId}
								</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>
									<i class="fa fa-circle text-green"></i>
									<%-- <c:if test="${not empty userid}"> --%>
									<!-- 변경/등록 버튼은 userid가 있는(관리자/회원)만 볼수있다.  -->
									<button type="button" class="btn btn-default" onclick="openButton(1)">등록</button>
									<button type="button" class="btn btn-default" onclick="openButton(0)">검색</button>
									<%-- </c:if> --%>
								</h3>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"	style="overflow-y: auto; width: auto; height: 650px;"></div>
					
							<!-- 대화입력창 시작  -->
							<div class="portlet-footer">
							
								<!-- 회원아이디 부분 시작  -->
								<div class="row">
									<div class="form-group col-xs-4">
										<!-- 로그인을 하면 회원아이디로 대체 -->
										<input id="nickname" type="hidden" value="${member.nickname }">
										<input style="width:100px; height: 40px;" name="nick" id="nick" 
										class="form-control" placeholder="이름" maxlength="8" readonly value="${member.nickname }">
									</div>

								<!-- 	<div class="form-group col-xs-2 pull-right">
										현재 접속자 표시 
										<button type="button" class="btn btn-default pull-right" onclick="openButton(3)"
										style="height: 40px; width: 100px;">현재	접속자</button>
									</div> -->
								</div>
								<!-- 회원 아이디 끝 -->
								<!-- 메세지 입력창 시작  -->
								<div class="row">
									<div id="text" class="form-group col-xs-10">
										<textarea style="width:80%; height: 80px;" id="contents" name="contents" class="form-control"
										 placeholder="메세지를 입력하세요." maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" id="sendBtn" class="btn btn-default pull-right"
										style="height: 80px; width: 100px;">전&nbsp;&nbsp;송</button>
									</div>
								</div>
								<!-- 메세지 입력창 끝 -->
							</div>
							<!-- 대화입력창 끝  -->
						</div>
					</div>
				</div>
			<!-- </div> -->
		<!-- </div> -->
	<!-- </div> --> 
</form>
</body>
</html>