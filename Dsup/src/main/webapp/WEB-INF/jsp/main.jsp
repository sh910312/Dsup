<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<%@include file="bar.jsp" %>
</div>    
 	${sessionScope.member.nickname} 님 안녕하세요!
 	<a href="logout">로그아웃</a>
 	
	<br><br><br><br><br><br><br><br><br>
	
	<button>SQL</button><br>
	<button onclick="location.href='./dbIndex'">DB</button><br>
	<button>종량제</button>
	
</body>
</html>