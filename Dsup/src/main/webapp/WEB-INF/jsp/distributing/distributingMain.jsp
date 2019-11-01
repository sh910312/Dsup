<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
</head>
<body>
	<div>
		<%@include file="../bar.jsp"%>
	</div>
	${member.nickname}님, 안녕하세요!
	<br>
	<%-- 전체용량 ${schemaUse.maxBytes} 중에서 사용량은 ${schemaUse.bytes} 입니다.
<div class="progress" style="width:50%; align:center;">
  <div class="progress-bar" role="progressbar" style="width:${schemaUse.usepct}%;" aria-valuenow="${schemaUse.usepct}" aria-valuemin="0" aria-valuemax="100">${schemaUse.usepct}%</div>
</div> --%>

	<form>
		<button>신청하기</button>
	</form>

</body>
</html>