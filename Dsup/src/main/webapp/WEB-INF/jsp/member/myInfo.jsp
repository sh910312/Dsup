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
<h3>내정보</h3>
아이디: ${member.userId}<br>
닉네임: ${member.nickname}<br>
이메일: ${member.eMail}<br>
가입날짜: <fmt:parseDate value="${member.userDate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/><br>

<button>정보변경</button>
</body>
</html>