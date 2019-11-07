<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User List</title>
	<link rel="stylesheet"	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../../DBbar.jsp" %>
<script>
	$(function() {
		userList(); //userList조회
		userUpdateForm(); //userUpdate수정팝업
		
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
			$('<tr>').append( $('<td>').html((item.USERNAME)))
					.append( $('<td>').html((item.ACCOUNT_STATUS)))
					.append( $('<td>').html((item.DEFAULT_TABLESPACE)))
					.append( $('<td>').html('<button id="btnDelete" class = "_btnDelete btn btn-outline-secondary" data-toggle="modal" data-target="#delModal">삭제'))
					.append( $('<td>').html('<button id="btnUpdate" class = "_btnUpdate btn btn-outline-secondary" data-toggle="modal" data-target="#updateModal">수정'))
					//.append( $('<td>').append( $("<input>").attr("type", "button").val("생성").attr("onclick", "location.href='userCreateForm'") ) )
					.append( $('<input type="hidden" id="hidden_userId">').val(item.USERNAME))
					.appendTo($('#userList'))
					;

		});
		
		userDelete(); // 유저 삭제
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
	
	
	
	
	var dialog, form;
	$(function() {
		// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
		id = $("#id"), 
		password = $("#password"),
		defaultTableSpace = $("#defaultTableSpace"),
		allFields = $([]).add(id)
						 .add(password)
						 .add(defaultTableSpace),
		tips = $(".validateTips");

		function updateTips(t) {
			tips.text(t).addClass("ui-state-highlight");
			setTimeout(function() {
				tips.removeClass("ui-state-highlight", 1500);
			}, 500);
		}

		function checkLength(o, n, min, max) {
			if (o.val().length > max || o.val().length < min) {
				o.addClass("ui-state-error");
				updateTips("Length of " + n + " must be between " + min
						+ " and " + max + ".");
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp(o, regexp, n) {
			if (!(regexp.test(o.val()))) {
				o.addClass("ui-state-error");
				updateTips(n);
				return false;
			} else {
				return true;
			}
		}

		function updateUser() {
			var valid = true;
			allFields.removeClass("ui-state-error");
/* 
			valid = valid && checkLength(id, "id", 3, 16);
			//console.log(id);
			valid = valid && checkLength(password, "password", 5, 16);
			valid = valid && checkLength(defaultTableSpace, "defaultTableSpace", 6, 80);
			valid = valid && checkLength(temporaryTableSpace, "temporaryTableSpace", 6, 80); */

			//valid = valid && checkRegexp( id, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
			if (valid) {
		/* 	    var id = $('input:text[name="id"]').val();
				var password = $('input:password[name="password"]').val();
				var defaultTableSpace = $('select[name="defaultTableSpace"]').val();
				var temporaryTableSpace = $('select[name="temporaryTableSpace"]').val();  */

				$.ajax({
					url : "users",
					type : 'PUT',
					dataType : 'JSON',
					data : JSON.stringify($("#form1").serializeObject()),
					contentType : 'application/json',
					success : function(data) {
						userList();
						dialog.dialog("close");
						
					},	error : function(xhr, status, message) {
						alert(" status: " + status + "er:" + message);
					}
				});

			}
			return valid;
		}

		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 500,
			width : 450,
			modal : true,

			buttons : {
				"수정" : updateUser,
				취소 : function() {
					dialog.dialog("close");
				}
			},
			close : function() {
				form[0].reset();
				allFields.removeClass("ui-state-error");
			}
		});

		form = dialog.find( "form" );
	});
	
	//수정폼
	function userUpdateForm() {
		$('body').on('click', '#btnUpdate', function() {
			var userId = $(this).closest('tr').find('#hidden_userId').val();
			dialog.dialog("open");
			$("#name").val(userId)
		});
	}
</script>
<div class = "container">

<!-- 
	<div id="dialog-form">
		<p class="validateTips"></p>
		<div class="form-group row">
		<form id="form1">
			<table>
					<tr>
						<td id="id">이름</td>
						<td><input readonly type="text" name="id" id="name" class="text ui-widget-content ui-corner-all">
						</td>
					</tr>
					<tr>
						<td id="password">비밀번호</td>
						<td><input type="password" name="password" maxlength="50">
						</td>
					</tr>

					<tr>
						<td id="password">비밀번호 확인</td>
						<td><input type="password" name="passwordcheck"	maxlength="50">
						</td>
					</tr>
					<tr>
						<td>default tablespace</td>
						<td><select name="defaultTableSpace">
						<c:forEach var="list" items="${tableSpaceList}">
							<option value="${list.tablespaceName}">${list.tablespaceName}</option>
						</c:forEach>
						</select>
					</tr>
					<tr>
						<td><input type="radio" name="accountStatus" value="lock" checked/>lock</td>
						<td><input type="radio" name="accountStatus" value="unlock"/>unlock</td>
					</tr>
			</table>
		</form>
	</div>
	</div>
 -->
	<div class = "row justify-content-between">
		<div class = "col">
			<h2>User 목록</h2>
		</div>
		<div class = "col-auto">
			<button type="button" onclick="location.href='userCreateForm'" class = "btn btn-outline-info">생성</button>
		</div>
	</div>
	
	<table class="table text-center table-hover">
		<thead>
			<tr>
				<th>아이디</th>
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
					<h5 class="modal-title" id="exampleModalLabel">유저 스키마 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id = "frm1">
						<div class = "form-group">
							이름:
							<input readonly type="text" name="id" id="name" class="form-control">
						</div>
						<div class = "form-group">
							비밀번호:
							<input type="password" name="password" maxlength="50" class = "form-control">
						</div>
						<div class = "form-group">
							비밀번호 체크:
							<input type="password" name="passwordcheck"	maxlength="50" class = "form-control">
						</div>
						<div class = "form-group">
							default tablespace:
							<select name="defaultTableSpace" class = "form-control">
							<c:forEach var="list" items="${tableSpaceList}">
								<option value="${list.tablespaceName}">${list.tablespaceName}</option>
							</c:forEach>
							</select>
						</div>
						<div class = "form-group">
							<div class = "row">
								<div class = "col">
									<input type="radio" name="accountStatus" value="lock" checked id="upd_lock"/>
									<label for="upd_lock">lock</label>
								</div>
								<div class = "col">
									<input type="radio" name="accountStatus" value="unlock" id="upd_unlock"/>
									<label for="upd_unlock">unlock</label>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-info" data-dismiss="modal">수정 완료</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>