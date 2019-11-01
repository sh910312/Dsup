<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<script>

$(function() {

	edit();
});

// 수정
function edit() {
	$("#editbtn").click(function() { // 버튼 id 값이 edit인놈을 클릭 이벤트 실행하였을때

		console.log("무사히 실행 되었다."); // 여기까지왔는지 로그확인
	
		$("#frm").submit();
	})
}

</script>





<form id="frm" action="updateSearch">
제목<input type="text" name="title" placeholder="${search.title}">
내용<input type="text" name="contents" value="${search.contents }">
<input type="hidden" name="searchId" value="${search.searchId }"/>
<button type="button" id="editbtn">수정하기</button>
</form>
<button type="button" id="backbtn" class="btn btn-default" onclick="history.go(-1)">돌아가기</button>



</body>
</html>