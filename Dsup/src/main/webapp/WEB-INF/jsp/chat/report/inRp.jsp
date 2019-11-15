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



<script>

$(function() {
	
	okbtn();
	
});

function okbtn() {
	$("#Okbtn").click(function() {

		$("#frm").attr("action", "RpOk");
		$("#frm").attr("method", "post");
		$("#frm").submit();
		alert("신고가 완료되었습니다.");
		self.close();
	})
}


window.onload = function(){		//db읽어온 텍스트 \n  -> <br> 바꿈
	var text = document.getElementById("updatecotents");
	var result = text.value.replace(/(\n|\r\n)/g, '<br>');
	document.getElementById("test").innerHTML = result;
}; 




</script>



</head>
<body>


<form id="frm">
	<div class="container">
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>신고합니다</h3>
							</div>
							<div class="portlet-title pull-right">
								
								
							</div>
							<div class="clearfix"></div>
						</div>
						<!-- 대화입력창  -->
						<div class="portlet-footer">
							
							<!-- 신고 상세내용 시작 -->
							<div class="row" align="center">
							
							<h3>신고 상세내용</h3>
							
							<!-- 신고타입 0번 = 게시글신고 // 1번은 = 댓글신고 // 2번 = 채팅신고 -->
							<h4><c:choose>
							
								<c:when test="${rpType == 0}">
								신고번호			 : ${search.searchId}<br>							
								신고대상  		 : ${search.userId }<br>
								게시글 등록날짜 	 : <fmt:formatDate value="${search.writeDate }" pattern="yy-MM-dd" /><br><br><br>
								- 신고 내용 -			  <br>
								<br>
								<div id="test" style="min-height:50px; overflow:auto; width: 60%;"></div>
								<input id="updatecotents" type="hidden" value="${search.contents }">
								<input type="hidden" name="rpUserId" value="${search.userId }" />
								<input type="hidden" name="boardNum" value="${search.searchId}" />
								</c:when>
														 
								<c:when test="${rpType == 1 }">
								신고번호			 : ${re.reId}<br>
								신고대상  		 : ${re.userId }<br>
								댓글 등록날짜 		 : <fmt:formatDate value="${re.writeDate }" pattern="yy-MM-dd" /><br><br><br>
								- 신고 내용 -			  <br>
								<br>
								<div id="test" style="min-height:50px; overflow:auto; width: 60%;"></div>
								<input id="updatecotents" type="hidden" value="${re.contents }">
								<input type="hidden" name="rpUserId" value="${re.userId }" />
								<input type="hidden" name="boardNum" value="${re.reId}" />
								</c:when>
							
							
								<c:when test="${rpType == 2 }">
								신고번호			 : ${chat.chatId}<br>
								신고대상자 		 : ${chat.userId }<br>
								채팅 입력날짜	 	 : <fmt:formatDate value="${chat.writeDate }" pattern="yy-MM-dd" /><br><br><br>
								- 신고 내용 -			  <br>
								<br>
								<div id="test" style="min-height:50px; overflow:auto; width: 60%;"></div>
								<input id="updatecotents" type="hidden" value="${chat.contents }">
								<input type="hidden" name="rpUserId" value="${chat.userId }" />
								<input type="hidden" name="boardNum" value="${chat.chatId}" />
								
								</c:when>
							</c:choose></h4>
							<!-- 신고 상세내용 끝 -->
	
							<textarea style="width:100%; height:100px;" id="rp_contents" name="rpContents" class="form-control" placeholder="신고사유를 작성하세요."></textarea>
								<br>
								<input type="hidden" name="searchId" value="${search.searchId }" />
								<input type="hidden" name="reId" value="${re.reId }" />
								<input type="hidden" name="userId" value="${chat.chatId }" />
								<input type="hidden" name="rpType" value="${rpType}" />
								
									<button type="button" id="Okbtn" name="Okbtn" class="btn btn-default">신고완료</button>
									<button type="button" id="close" name="close" class="btn btn-default" onclick="self.close();">닫기</button>
	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>