<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>로그인</h3>
<form action="login" method="post">
	<input name="userId" value="${requestScope.member.userId }"/>
	<input name="password" value="${memberVO.password }"/>
	<button>로그인</button>
</form>
</body>
</html>