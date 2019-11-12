<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%@include file="../bar.jsp"%>
	</div>
${member.nickname}님, 안녕하세요!
	
	전체용량 ${schemaUse.maxBytes} 중에서 사용량은 ${schemaUse.bytes} 입니다.
	<div class="progress" style="width:50%; align:center;">
 		<div class="progress-bar" role="progressbar" style="width:${schemaUse.usepct}%;" aria-valuenow="${schemaUse.usepct}" aria-valuemin="0" aria-valuemax="100">${schemaUse.usepct}%</div>
	</div>
</body>
</html>