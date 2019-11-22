<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User List</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<!-- 부트스트랩 -->

</head>
<body>
<%@include file="../../DBbar.jsp" %>

<script>
	$(function() {
		userList(); //userList조회
		userUpdateForm(); //userUpdate수정팝업
		userUpdate();
		userDelete();
		// serializeObject
		$.fn.serializeObject = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name]) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};
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
	//비밀번호 입력확인
	$(function(){
		$("#passwordcheck,#modalPassword").keyup(function(){
			if( $("#modalPassword").val() != "")
				if( $("#modalPassword").val() == $("#passwordcheck").val()) { // 둘 다 똑같이 입력했으면
					$("#passwordChkMsg").html("비밀번호가 일치합니다.").css("color", "green");
					$("#passwordResult").val("true");
				} else { // 다르게 입력했으면
					$("#passwordChkMsg").html("비밀번호가 일치하지 않습니다.").css("color", "red");
					$("#passwordResult").val("false");
				}
		});
	});
	function formCheck(){
		
		if( $("#modalPassword").val() != $("#passwordcheck").val()){
			alert("비밀번호를 확인하세요!");
			return false;
		}
		
		else if($("#passwordResult").val()=="false"){
			alert("비밀번호를 확인하세요!");
			return false;
		}
		
		else if($("#modalPassword").val() == ""){
			alert("비밀번호를 입력하세요");
			return false;	
		}
		
		return true;
	}
	
	
	//목록조회응답
	function userListResult(data) {
		$("#userList").empty();
		$.each(data, function(idx, item) {
			$('<tr>').append( $('<td>').html((item.USERNAME)))
					.append( $('<td>').html((item.ACCOUNT_STATUS)))
					.append( $('<td>').html((item.DEFAULT_TABLESPACE)))
					.append( $('<td>').html('<button id="btnDelete" class = "_btnDelete btn btn-outline-secondary" data-toggle="modal" data-target="#delModal">삭제'))
					.append( $('<td>').html('<button id="btnUpdate" class = "_btnUpdate btn btn-outline-secondary" data-toggle="modal" data-target="#updateModal">수정'))
					.append( $('<input type="hidden" id="hidden_userId">').val(item.USERNAME))
					.appendTo($('#userList'))
					;

		});
		userDelete(); // 유저 삭제
		userUpdate();
	}

	//삭제
	function userDelete() {
		$("._btnDelete").click(function(){
			var userId = $(this).closest('tr').find('#hidden_userId').val(); //선택한것에 val 값을 가져오겠다
			console.log(userId);
			// 모달 창에서 삭제 버튼 클릭하면
			$("#modalDelBtn").click(function(){
				$.ajax({
					url : 'users/' + userId,
					type : 'DELETE',
					contentType : 'application/json;charset=utf-8',
					dataType : 'json',
					error : function(xhr, status, msg) {
						console.log("상태값:" + status + " Http에러메세지: " + msg);
					},
					success : function(xhr) {
						console.log(xhr.result);
						$('#delModal').modal('hide')
						userList();
					}
				});
			})
		});
	}
	
	// ↓ 수정 모달 새로 만든것
	function userUpdate() {
		$("._btnUpdate").click(function(){
			var userId = $(this).closest('tr').find('#hidden_userId').val(); //선택한것에 val 값을 가져오겠다
			$("#name").val(userId);
			$("#modalPassword").val("");
			$("#passwordcheck").val("");
			userUpdate.isLoad = false;
			
		
			// ↓ 모달에서 수정 버튼 눌렀을 때
			$("#modalUpdBtn").click(function(e){
				e.stopPropagation();
				var condition = formCheck();
				var id = $("#name").val();
				var password = $("#modalPassword").val();
				var defaultTableSpace = $("#modalDefault").val();
				var accountStatus = $("input:radio[name='accountStatus']").val();
				
				var formData = $("#form1").serializeObject();
				console.log(formData);
				console.log(userUpdate.isLoad);
				if(userUpdate.isLoad != true && condition == true){
					$.ajax({
						url : "users",
						type : 'PUT',
						dataType : 'JSON',
						data : JSON.stringify( formData ),
						//data : JSON.stringify({id: id, password:password, defaultTableSpace:defaultTableSpace, accountStatus:accountStatus}),
						contentType : 'application/json',
						success : function(data) {
							$("#form1")[0].reset();
							$('#updateModal').modal('hide');
							userList();
						},	error : function(xhr, status, message) {
							alert(" status: " + status + "er:" + message);
						}
					}); // ajax
					userUpdate.isLoad = true;
				}
			}); // modalUpdBtn click
		}) // _btnUpdate click
	} // userUpdate
	
	//수정폼
	function userUpdateForm() {
		$('body').on('click', '#btnUpdate', function() {
			var userId = $(this).closest('tr').find('#hidden_userId').val();
			$("#name").val(userId)
		});
	}
</script>
<div class = "container">
	<div class = "row justify-content-between">
		<div class = "col">
			<h2>스키마 목록</h2>
		</div>
		<div class = "col-auto">
			<button type="button" onclick="location.href='userCreateForm'" class = "btn btn-outline-info">생성</button>
		</div>
	</div>
	<div style = "margin-bottom: 20px "></div>
	<table class="table text-center table-hover">
		<thead>
			<tr>
				<th>SCHEMA ID</th>
				<th>ACCOUNTSTATUS</th>
				<th>DEFAULTTABLESPACE</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody id="userList">
		</tbody>
	</table>
	
	<!-- 삭제시 모달 등장 -->
	<div class="modal fade" id="delModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">경고</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					삭제하시겠습니까?
					<br><br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-info" id = "modalDelBtn" data-dismiss="modal">삭제</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 수정 모달 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">스키마 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id = "form1">
						<div class = "form-group">
							스키마아이디:
							<input readonly type="text" name="id" id="name" class="form-control">
						</div>
						<div class = "form-group">
							비밀번호:
							<input type="password" name="password" placeholder="PASSWORD" maxlength="50" class = "form-control" id="modalPassword" required>
						</div>
						<div class = "form-group">
							비밀번호 체크:
							<input type="password" name="passwordcheck"	placeholder="PASSWORD" maxlength="50" class = "form-control" id="passwordcheck" required>
							<span id = "passwordChkMsg"> </span>
						</div>
						<div class = "form-group">
							default tablespace:
							<select name="defaultTableSpace" class = "form-control" id="modalDefault">
							<c:forEach var="list" items="${tableSpaceList}">
								<option value="${list.tablespaceName}">${list.tablespaceName}</option>
							</c:forEach>
							</select>
						</div>
						<div class = "form-group">
							잠금 여부:
							<div class = "row">
								<div class = "col">
									<input type="radio" name="accountStatus" value="lock" id="upd_lock"/>
									<label for="upd_lock">lock</label>
								</div>
								<div class = "col">
									<input type="radio" name="accountStatus" value="unlock" id="upd_unlock" checked/>
									<label for="upd_unlock">unlock</label>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-info" data-dismiss="modal" id="modalUpdBtn">수정 완료</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>