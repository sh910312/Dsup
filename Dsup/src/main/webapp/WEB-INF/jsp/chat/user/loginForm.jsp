<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<script>
$(function() {
	
	checkForm();
});

function checkForm() {
	var thisForm = document.frm;
	if (thisForm.id.value == '') {
		alert("아이디를 입력 하세요.");
		thisForm.id.focus();
		return false;
	} else if (thisForm.pw.value == '') {
		alert("비밀번호를 입력하세요.");
		thisForm.pw.focus();
		return false;
	}

	thisForm.submit();
}


</script>
<body>

<div align="center">
<br>
<form name="frm" action="Login.do" method="post">
<input style="width:200px; height: 40px;" type="text" id="#" class="form-control" placeholder="아이디" maxlength="10">
<input style="width:200px; height: 40px;" type="password" id="#" class="form-control" placeholder="비밀번호" maxlength="20">
<button type="button" class="btn btn-default" onclick="checkForm();">로그인</button>
<button type="button" class="btn btn-default" onclick="openButton(1);">회원가입</button>
<br>

<a href="main.jsp" onclick="#">비회원으로 접속</a>
</form>
</div>
</body>
</html>