<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/json.min.js"></script>
<script>
	$(function() {
		userList(); //userList조회
		userDelete(); //user삭제
	});
	//목록조회요청
	function userList() {
		$.ajax({
			url : 'users',
			type : 'GET', //요청방식
			dataType : 'json', //결과 데이터 타입
			error : function(xhr, status, mag) {
				alert("상태값:" + status + " Http에러메세지 : " + msg)
			},
			success : userListResult
		});
	}

	//목록조회응답
	function userListResult(data) {
		$("#userList").empty();
		$.each(data, function(idx, item) {
			$('<tr>').append($('<td>').html(item.USERNAME)).append(
					$('<td>').html('<button id="btnDelete">삭제')).append(
					$('<td>').html('<button id="btnUpdate">수정')).append(
					$('<input type="hidden" id="hidden_userId">').val(
							item.USERNAME)).appendTo('#userList');
			// <input type = "hidden" id = "hidden_userId" value="item.USERNAME">
		});
	}

	//삭제
	function userDelete() {
		$('body').on('click', '#btnDelete', function() {
			var userId = $(this).closest('tr').find('#hidden_userId').val(); //선택한것에 val 값을 가져오겠다
			var result = confirm(userId + "삭제하시겠습니까?");
			if(result){
				$.ajax({
					url:'users/'+userId,
					type:'DELETE',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					error:function(xhr,status,msg){
						console.log("상태값:" + status + " Http에러메세지: " + msg);
					},  success:function(xhr){
						console.log(xhr.result);
						userList();
					}
				});
			}
		});
	}
	//수정
	function userUpdate(){
		$('#btnUpdate').on('click', function(){
			var id = $('input:text[name="id"]').val();
			$.ajax({
				url: "users",
				type: 'PUT',
				dataType: 'json',
				data: JSON.stringify({ id: id}),
				contenType: 'application/json',
				success: function(data){
					userList();
				},
				error:function(xhr, status, message){
					alert(" status: " + status + "er:" + message);
				}
			});
		});
	}
</script>
</head>
<body>
	<div class="container">
		<h2>User 목록</h2>
		<table class="table text-center">
			<thead>
				<tr>
					<th>아이디</th>
				</tr>
			</thead>
			<tbody id="userList">
			</tbody>
		</table>
	</div>
</body>
</html>