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
	
	update();
	
	back();
});

function update() { // 게시글 수정
	
	$("#updatebtn").click(function() {
		$("#frm1").attr("action", "updateSearch");
		$("#frm1").submit();
		alert("수정이 완료되었습니다.")

	})
}


function back() {
	
	$("#backbtn").click(function() {
		$("#frm1").attr("action", "getSearch");
		$("#frm1").submit();
	})
} 




</script>



</head>
<body>
<form id="frm1">
	<div class="container">
			<div class="row">
				<div class="col-xs-13">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h3><font color="black"><input id="title" name="title" style="width:100%;" type="text" value="${search.title }"></font></h3>
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
								
								<br>
									<%-- <input type="text" id="updatecotents" style="width:100%; height:200px; overflow:auto;"  readonly value="${search.contents }"> --%>
									<input hidden="hidden"/> <!-- 엔터키 안먹게 하는방법  -->
									<textarea style="width:100%; height:200px;" id="contents" name="contents" class="form-control" placeholder="${search.contents }"></textarea>
								<br>
								<div align="center">
								<br>
							
							<!-- Search내용 끝 -->
								<input type="hidden" name="searchId" value="${search.searchId }" />
									<button type="button" id="updatebtn" name="updatebtn" class="btn btn-default">수정</button>
									<button type="button" id="backbtn" name="backbtn" class="btn btn-default">돌아가기</button>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
<script type="text/javascript">

function go_page(p){
	document.frm.page.value= p;
	document.frm.submit();
}

</script>



</body>
</html>