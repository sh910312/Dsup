<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>
	<img src="././resources/images/sql/icon.png">
	<P>The time on the server is ${serverTime}.</P>
	<!-- 윤정 -->
	<a href = "dbIndex">DB관리</a>
	<a href = "login">로그인</a>
	<a href = "logout">로그아웃</a>
	<br>
	 아이디  : ${userId}
	
	<hr>
	
	<!-- 재문 -->
	<a href = "sqlIndex">SQL</a>
</body>
</html>
