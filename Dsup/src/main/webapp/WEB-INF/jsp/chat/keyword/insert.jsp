<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="insertSearch" method="post">

	제목<input name="title">
	<button>검색</button>
</form>

<br>
<br>
<c:forEach items="${searchlist}" var="search">
		<div>
		 ${search.search_id }
		 ${search.title }
		 ${search.contents }
		 ${search.user_id }
		 ${search.write_date }
		</div>
</c:forEach>

</body>
</html>