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
function openButton(menu,a){ /*  버튼 새창 */ // menu,a >> 첫번째와 두번째 값으로 넘겼음
	
	var popupX = (document.body.offsetWidth / 2) - (100/2);
	var popupY = (document.body.offsetHeight / 2) - (200/2);

	if (menu == "0" || menu == 0){ // 게시글신고
		
		console.log("aaaaaaaaaa")
		
		// rpId에 게시글 넘버 넣기, type은 0으로 지정 하기
		window.open("getRp?searchId=${search.searchId }","게시글신고",'width=484px, height=523px, left='+ popupX + ', top='+ popupY);
		//window.open("getRp","게시글신고",'width=484px, height=523px, left='+ popupX + ', top='+ popupY);
	
	}else if(menu == "1" || menu == 1){ // 댓글 신고
		
		console.log(a);
		
		window.open("getRp?reId="+a,"댓글신고",'width=484px, height=523px, left='+ popupX + ', top='+ popupY);
	}
	
}



$(function() {

	update();   // 게시글 업데이트
	del();      // 게시글 삭제

	insertRe(); // 댓글 등록
	updateRe(); // 댓글 업데이트
	delRe();    // 댓글 삭제

	back();     // 돌아가기

});




function update() { // 게시글 수정
	console.log("update");
	
	$("#updatebtn").click(function() { 

		$("#frm1").attr("action", "editSearch");
		$("#frm1").submit();
	})
	
}

function del() { // 게시글 삭제
	
	console.log("del");
	
	$("#delbtn").click(function() {
		
		$("#frm1").attr("action", "deleteSearch");
		$("#frm1").submit();
		alert(${search.searchId } + "번 게시글이 삭제 되었습니다.");
	})
}




function insertRe() { // 댓글 등록

	console.log("insertRe");
	
 	$("#insertbtn").click(function() {
		
		if($("#contents").val().length==0){
			alert("내용을 입력하세요");
			$("#contents").focus();
			return false;
		}
 		
		$("#frm2").attr("action", "insertRe");
		$("#frm2").attr("method", "post");
		$("#frm2").submit();
	}) 

}


function updateRe() { // 댓글 업데이트 
	
	//수정하기 버튼
	$(document).on('click','.updateRebtn',function(){	
		var text = $(this).parent().parent().find("#editform").text();
		$(this).parent().parent().find("#editform").html("<input type='text' name='contents' value='"+text+"' id='editDo'>");
		$(this).parent().html("<button type='button' id='btnDo' class='updateOk btn btn-default btn-xs pull-right'>수정완료</button>");
	})
	
	//수정완료버튼
	$(document).on('click','.updateOk',function(){
		var contents = $("#editDo").val();
		
		// 내용 입력을 다 했으면 실행
		$("#frmEditRe").attr("action", "updateRe");

		frmEditRe.contents.value=contents;
		frmEditRe.reId.value=$(this).parent().parent().find("#reId").val();

		console.log($(this).parent().parent().find("#reId").val());
		
		$(this).parent().parent().find("#editform").text(contents);
		$(this).parent().html('<button type="button" id="updateRebtn" class="updateRebtn btn btn-default btn-xs pull-right">댓글 수정</button>');
		
		$("#frmEditRe").submit();
	});

}



function delRe() { // 댓글 삭제
	
	console.log("delRe");
	
	$(".delRebtn").click(function() { // 댓글 삭제 버튼을 클릭했을때
		
		frmdel.reId.value=$(this).parent().parent().find("#reId").val();
		console.log($(this).parent().parent().find("#reId").val());
		
		// 실행하라
		$("#frmdel").attr("action", "delRe");
		$("#frmdel").submit();
		alert("댓글이 삭제되었습니다.");
	})
}


function back() { // 돌아가기
	
	$("#backbtn").click(function() {
		$("#frm1").attr("action", "SearchMap");
		$("#frm1").submit();
	})
} 


window.onload = function(){ //db읽어온 텍스트 \n  -> <br> 바꿈
	
	window.resizeTo(728,700);
	var text = document.getElementById("updatecotents");
	var result = text.value.replace(/(\n|\r\n)/g, '<br>');
	document.getElementById("test").innerHTML = result;
}; 


$(document).ready(function(){
	$('#updateRebtn').click(function(){
		var offset = $('#editbtn').offset(); //선택한 태그의 위치를 반환
            //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 
        $('html').animate({scrollTop : offset.top}, 400);
	});
});


</script>
</head>
<body>  
	<div class="container">
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
					
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3>${search.title }</h3>
							</div>
							<div class="portlet-title pull-right">
								<h3>${search.userId }
									<fmt:formatDate value="${search.writeDate}" pattern="yy-MM-dd HH:mm" />
								</h3>
							</div>
							<div class="clearfix"></div>
						</div>
					
					
					
					
						<!-- 대화입력창  -->
						<div class="portlet-footer">
							
							
							<!-- Search내용 시작 -->
							<div class="row">
								<form id="frm1">
								<br>
									<div id="test" style="max-height:100px; overflow:auto; width: 100%;"></div>
									<input id="updatecotents" type="hidden" value="${search.contents }">
								<c:if test="${userId != search.userId }">
								<div class="pull-right"><a id="rpSearch" style="cursor:pointer;" onclick="openButton(0,${search.searchId })">게시글 신고하기</a></div>
								</c:if>
								<div align="center">
								<br>
							
							<!-- Search내용 끝 -->
							
							
							
							
							<!-- Search 버튼 구역 -->
								<c:if test="${userId == search.userId}">
								<input type="hidden" name="searchId" value="${search.searchId }" />
									<button type="button" id="updatebtn" name="updatebtn" class="btn btn-default">수정</button>
									<button type="button" id="delbtn" name="delbtn" class="btn btn-default">삭제</button>
								</c:if>	
									<button type="button" id="backbtn" name="backbtn" class="btn btn-default">돌아가기</button>
								</div>
								</form>
							</div>
							<!-- Search 버튼 구역 끝 -->							
							
							
							
							
							
							<!-- 댓글 목록 시작  -->
							<div class="row">
								<form id="frm3">
								<hr>
								<div id="Recontents" class="form-group col-xs-12">
									<input type="hidden" name="searchId" value="${search.searchId }">

							
							<!-- 댓글 리스트 반복문 시작 -->
								<c:forEach items="${reList }" var="re">
								<div id="${re.reId }">
									<input type="hidden" name="reId" id="reId" value="${re.reId }" >

										${re.userId }
										${re.writeDate }
									<c:if test="${userId != re.userId }">
										<button type="button" class="btn btn-default btn-xs" onclick="openButton(1,${re.reId })">신고</button>
									</c:if>
									<c:if test="${userId == re.userId }">
										<div id="delRebtn"><button type="button" id="delRebtn" name="delRebtn" class="delRebtn btn btn-default btn-xs pull-right">댓글 삭제</button></div>
										<div id="editbtn"><button type="button" id="updateRebtn" class="updateRebtn btn btn-default btn-xs pull-right">댓글 수정</button></div>
									</c:if>
										<div id="editform">${re.contents }</div> 
										<br>
								</div>
								<input type="hidden" name="page" value="1"/>
								</c:forEach>
							<!-- 댓글 리스트 반복문 끝 -->							
							
							
							<!-- 페이징 처리 영역-->
									<div class="form-group col-xs-12" align="center">
									<my:paging paging="${paging}" jsFunc="go_page"/>
									</div>
							<!-- 페이징 처리 영역 끝-->
								</div>
								</form>
							</div>
							<!-- 댓글목록 끝 -->



								
							<!-- 등록 폼 시작 -->
							<div class="row">
								<div class="col-lg-12">
								<form id="frm2" class="form-inline" action="insertRe" method="POST">
								<input type="hidden" name="searchId" value="${search.searchId }">
								
								<!-- 버튼가 인풋박스 함께 넣는법 : float 이용하기  -->
									<input type="text" style="width: 85%; height: 40px; float:left" name="contents" id="contents" class="form-control" placeholder="댓글을 입력하세요." maxlength="50">
									<button type="button" id="insertbtn" name="insertbtn" class="btn btn-default" style="width: 10%; height:40px; float:right">등록 </button>
								</form>									
								</div>
							<!-- 등록 폼 끝 -->
								
							<!-- 댓글 조회 폼 -->
								<form name="frm">
									<input type="hidden" name="searchId" value="${search.searchId }" />
									<input type="hidden" name="page" value="1"/> <!-- 페이징 -->
								</form>
							<!-- 댓글 조회 폼 끝 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<form id="frmEditRe" name="frmEditRe">
<input type="hidden" name="searchId" value="${search.searchId }">
<input type="hidden" name="reId">
<input type="hidden" name="contents">
</form>

<form id="frmdel" name="frmdel">
<input type="hidden" name="searchId" value="${search.searchId }">
<input type="hidden" name="reId">
</form>




<script type="text/javascript">

function go_page(p){
	document.frm.page.value= p;
	document.frm.submit();
}

</script>

</body>
</html>