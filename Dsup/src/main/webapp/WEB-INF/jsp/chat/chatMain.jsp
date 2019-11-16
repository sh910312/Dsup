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
<link rel="stylesheet" href="./resources/css/bootstrap.css">
<script src="./resources/js/sockjs.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./resources/js/bootstrap.js"></script>

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
		    	
//    	var data = msg.data;
//		
//    	$("#chatList").append(data + "&nbsp;"
//		+ "<button type='button' class='btn btn-default btn-xs' onclick='openButton(2, this)'>" 
//		+ "신고" + "</button>"
//		+ "<hr>"
//		);
//		$('#chatList').scrollTop($('#chatList')[0].scrollHeight); // 채팅 최신 상태 유지
    	var data = JSON.parse(msg.data);
    	
    	console.log(data);
    	
    	switch(data.cmd){
    	
    		case "login":
    			$("#chatList").append(data.msg + "<hr>");
    			break;
    		
    		case "msge":
    			$("#chatList").append(data.msg + "&nbsp;"
    				+ "<button type='button' class='btn btn-default btn-xs' onclick='openButton(2, this)'>" 
    				+ "신고" + "</button>"
    				+ "<hr>"
    			);
    			break;
    	
			case "logout":
				$("#chatList").append(data.msg + "<hr>");
    			break;
    	}
    	
    	
		
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight); // 채팅 최신 상태 유지
    
    }
    
    // 서버와 연결을 끊었을 때
    function onClose(evt) {
		$("#data").appendMessage("연결 끊김");
    }
    
    // 서버와 연결을 되었을 때 자동 발송
    function onOpen(evt) {
		$("#data").appendMessage("연결 되었습니다.");
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
		var option = 'width=484px, height=570px, left='+ popupX + ', top='+ popupY; 
		window.open(url,name,option);
	}else if(menu == "3" || menu == 3){
		window.open("online","온라인",'width=200px, height=550px, left='+ popupX + ', top='+ popupY )
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
									D-sup 실시간 전체채팅 ${chat.chatId}
								</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>
									<%-- <c:if test="${not empty userid}"> --%>
									<!-- 변경/등록 버튼은 userid가 있는(관리자/회원)만 볼수있다.  -->
									<button type="button" class="btn btn-default" onclick="openButton(0)">검색하기</button>
									<%-- </c:if> --%>
								</h3>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"	style="overflow-y: auto; width: auto; height: 560px;"></div>
					
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

<!-- 								<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default" onclick="openButton(3)"
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