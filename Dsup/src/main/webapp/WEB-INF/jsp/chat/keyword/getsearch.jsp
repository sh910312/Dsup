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
		window.open("getRp?searchId=${search.searchId }","게시글신고",'width=800px, height=300px, left='+ popupX + ', top='+ popupY);

	
	}else if(menu == "1" || menu == 1){ // 댓글 신고
		
		console.log(a);
		
		window.open("getRp?reId="+a,"댓글신고",'width=800px, height=300px, left='+ popupX + ', top='+ popupY);
	}
	
}

</script>




<script>



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
		alert("댓글이 수정되었습니다.");
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
		
		$("#frm2").attr("action", "insertRe");
		$("#frm2").attr("method", "post");
		$("#frm2").submit();
		alert("댓글이 등록 되었습니다.");
		
	}) 

}


function updateRe() { // 댓글 업데이트

	console.log("updateRe");
	

	
	$("#updateRe").click(function() { // 수정 버튼 클릭했을때
		console.log("실행이 되지 말아야 하는데 되는 펑션");
		
		// 수정내용 쓰기
		
		
		
		// 내용 입력을 다 했으면 실행
		$("#frm3").attr("action", "updateRe");
		$("#frm3").submit();
		
	})
	
}


function delRe() { // 댓글 삭제
	
	console.log("delRe");
	
	$("#delRebtn").click(function() {
		$("#frm3").attr("action", "delRe");
		$("#frm3").submit();
		alert("댓글이 삭제되었습니다.");
	})
	
}


function back() { // 돌아가기
	
	$("#backbtn").click(function() {
		$("#frm1").attr("action", "SearchMap");
		$("#frm1").submit();
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
									<fmt:formatDate value="${search.writeDate}" pattern="yy-MM-dd" />
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
									<div id="test"></div>
									<input id="updatecotents" type="hidden" value="${search.contents }">
								<br>
								<div class="pull-right"><a id="rpSearch" onclick="openButton(0,${search.searchId })">게시글 신고하기</a></div>
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
										<input type="hidden" name="reId" value="${re.reId }" >
											${re.userId }  :
											${re.contents } 
											${re.writeDate }
										<button type="button" class="btn btn-default btn-xs" onclick="openButton(1,${re.reId })">신고</button>
										<c:if test="${userId == re.userId }">
											<button type="button" id="delRebtn" name="delRebtn" class="btn btn-default btn-xs pull-right">댓글 삭제</button>
											<button type="button" id="updateRebtn" class="btn btn-default btn-xs pull-right">댓글 수정</button>
										</c:if>
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
								<div class="form-group col-lg-12" align="center">
								<form id="frm2" class="form-inline" action="insertRe" method="POST">
								<input type="hidden" name="searchId" value="${search.searchId }">
									<input type="text" style="width: 80%; height: 40px;" name="contents" id="contents" class="form-control" placeholder="댓글을 입력하세요." maxlength="20">
									<button type="button" id="insertbtn" name="insertbtn" class="btn btn-default" style="width: 100px; height:40px;">등록 </button>
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




<script type="text/javascript">

function go_page(p){
	document.frm.page.value= p;
	document.frm.submit();
}

</script>


</body>
</html>