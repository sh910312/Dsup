<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="insertBoard" method="post" enctype="multipart/form-data">

	제목<input name="title">
	내용<input name="contents">
	등록날짜<input name="write_date">
	등록자<input name="user_id">
	<button>등록</button>
</form>


</body>
</html>