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
function openButton(menu){ /*  버튼 새창 */
	
	var popupX = (document.body.offsetWidth / 2) - (100/2);
	var popupY = (document.body.offsetHeight / 2) - (200/2);

	if (menu == "0" || menu == 0){
		window.open("insertSearchForm","등록",'width=800px, height=300px, left='+ popupX + ', top='+ popupY);
	}

}

</script>

<script>




$(function() {
	
	del();
	update();
	
	
	insertRe();
	updateRe();

	
	
});

function insertRe() {
	$("#insertbtn").click(function() {

		$("#frm2").attr("action", "insertRe");
		$("#frm2").attr("method", "post");
		$("#frm2").submit();
		
	})
}

function updateRe() { // 댓글 업데이트

	$("[name='updateReOk']").hide(); // 댓글 수정완료 버튼 숨기기
		
		
	$("#updateRe").click(function() {
		
		$("#updateRe").hide();		// 댓글 수정버튼 숨기기
		$("#updateReOk").show(); // 댓글 수정완료 버튼 보이기
		$("#deleteRe").hide();		// 댓글 삭제버튼 숨기기
			
	})
	
	$("#updateReOk").click(function() {
		
		//수정 완료
		$("#frm3").attr("action", "컨트롤러에 있는 댓글수정완료");
		$("#frm3").submit();
		
		
	})
	
}

function del() { // 게시글 삭제
	$("#delbtn").click(function() {
		$("#frm1").attr("action", "deleteSearch");
		$("#frm1").submit();
		
	})
}
function update() { // 게시글 수정
	
	$("#updatebtnOk").hide(); 		// 수정완료 버튼 숨기기
	
	
	$("#updatebtn").click(function() {
		
		$("#updatecotents").attr("readonly", false);
		$("#updatecotents").focus();
		$("#updatebtnOk").show(); 	// 수정완료 버튼 보여주기
		$("#updatebtn").hide();   	// 수정 버튼 숨기기
		$("#delbtn").hide();		// 삭제버튼 숨기기


	})
	
	$("#updatebtnOk").click(function() {
	
		$("#frm1").attr("action", "updateSearch");
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
									<fmt:formatDate value="${search.writeDate }" pattern="yy-MM-dd" />
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
									<%-- <input type="text" id="updatecotents" style="width:100%; height:200px; overflow:auto;"  readonly value="${search.contents }"> --%>
									<input id="updatecotents" type="hidden" value="${search.contents }">
								<br>
								<div class="pull-right"><a href="#">게시글 신고하기</a></div>
								<div align="center">
								<br>
							
							<!-- Search내용 끝 -->
								<input type="hidden" name="searchId" value="${search.searchId }" />
									<button type="button" id="delbtn" name="delbtn" class="btn btn-default">삭제</button>
									<button type="button" id="updatebtn" name="updatebtn" class="btn btn-default">수정</button>
									<button type="button" id="updatebtnOk" name="updatebtnOk" class="btn btn-default">수정완료</button>
									<button type="button" id="back" name="back" class="btn btn-default" onclick="history.go(-1)">돌아가기</button>
								</div>
								</form>
							</div>
							
							
							<!-- 댓글 목록 시작  -->
							<div class="row">
								<form id="frm3">
								<hr>
								<div class="form-group col-xs-12">
									<c:forEach items="${reList }" var="re">
										${re.userId }  :
										${re.contents } 
										${re.writeDate }
									<button type="button" id="reportRe" name="reportRe" class="btn btn-default btn-xs">신고</button>
									<button type="button" id="deleteRe" name="deleteRe" class="btn btn-default btn-xs pull-right">삭제</button>
									<button type="button" id="updateReOk" name="updateReOk" class="btn btn-default btn-xs pull-right">수정완료</button>
									<button type="button" id="updateRe" name="updateRe" class="btn btn-default btn-xs pull-right">수정</button>
										<br>
										<br>
									</c:forEach>
									<div class="form-group col-xs-12" align="center">
									<my:paging paging="${paging}" jsFunc="go_page"/>
									</div>
								</div>
								</form>
							</div>
							
							<!-- 댓글목록 끝 -->
								
							<!-- 등록 폼 시작 -->
							<div class="row">
								<form id="frm2">
								<input type="hidden" name="searchId" value="${search.searchId }">
									<input style="width:80%; height: 40px;" name="contents" id="contents" class="form-control" placeholder="댓글을 입력하세요." maxlength="20">
									<button type="button" id="insertbtn" name="insertbtn" class="btn btn-default" style="height:40px;">등록 </button>
								</form>									
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