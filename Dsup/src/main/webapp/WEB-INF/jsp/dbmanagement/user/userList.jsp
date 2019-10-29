<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/json.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		userList(); //userList조회
		userDelete(); //user삭제
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
			$('<tr>').append($('<td>').html(item.USERNAME)).append(
					$('<td>').html(item.LOCK_DATE)).append(
					$('<td>').html(item.DEFAULT_TABLESPACE)).append(
					$('<td>').html(item.TEMPORARY_TABLESPACE)).append(
					$('<td>').html('<button id="btnDelete">삭제')).append(
					$('<td>').html('<button id="btnUpdate">수정')).append(
					$('<input type="hidden" id="hidden_userId">').val(item.USERNAME)).appendTo('#userList');

			// <input type = "hidden" id = "hidden_userId" value="item.USERNAME">
		});
	}

	//삭제
	function userDelete() {
		$('body').on('click', '#btnDelete', function() {
			var userId = $(this).closest('tr').find('#hidden_userId').val(); //선택한것에 val 값을 가져오겠다
			var result = confirm(userId + "삭제하시겠습니까?");
			if (result) {
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
						userList();
					}
				});
			}
		});
	}
	var dialog, form;
	$(function() {
		// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
		id = $("#id"), 
		password = $("#password"),
		defaultTableSpace = $("#defaultTableSpace"),
		temporaryTableSpace = $("#temporaryTableSpace"), 
		allFields = $([]).add(id)
						 .add(password)
						 .add(defaultTableSpace)
						 .add(temporaryTableSpace),
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
						//userList();
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
</head>
<body>
	<div id="dialog-form">
		<p class="validateTips"></p>

		<div class="form-group row">
		<form id="form1">
			<table>
					<tr>
						<td id="id">이름</td>
						<td><input type="text" name="id" id="name" class="text ui-widget-content ui-corner-all">
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
								<option value="USERS">USERS</option>
						</select>
					</tr>

					<tr>
						<td>temporary tablespace</td>
						<td><select name="temporaryTableSpace">
								<option value="TEMP">TEMP</option>
						</select>
					</tr>
					<tr>
						<td><input type="radio" name="lock" value="lock" checked/>lock</td>
						<td><input type="radio" name="lock" value="unlock"/>unlock</td>
					</tr>
			</table>
		</form>
	</div>
	</div>

	<div class="container">
		<h2>User 목록</h2>
		<table class="table text-center">
			<thead>
				<tr>
					<th>아이디</th><th>Lock</th><th>DEFAULTTABLESPACE</th><th>TEMPORARYTABLESPACE</th>
				</tr>
			</thead>
			<tbody id="userList">
			</tbody>
		</table>
	</div>
</body>
</html>