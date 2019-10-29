<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${sessionScope.user.name}
	<a href="Logout">로그아웃</a>
	<a href="">정보변경</a>
	<br><br><br><br><br><br><br><br><br>
	
	<button>SQL</button><br>
	<button>DB</button><br>
	<button>종량제</button>
</body>
</html>