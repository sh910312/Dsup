<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	function goPage(){
		location.href=document.getElementById("menu").value
	}
	
</script>
<div style="text-align: right">
프로필<select id="menu" onchange="goPage()">
	<option value="">쪽지함</option>
	<option value="">채팅봇</option>
	<option value="">Q &amp; A</option>
	<option value="myInfo">정보변경</option>
	<option value="logout">로그아웃</option>
</select>
</div>
