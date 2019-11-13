<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body>
	<%@include file="../../DBbar.jsp" %>
	<script src="./resources/json.min.js"></script>
<script>
	$(function() {
		userCreate(); //user등록
		idCheckFunction(); //id체크
		formCheck(); //비밀번호체크
	});
	//비밀번호 입력확인
	$(function(){
		$("#passwordcheck,#password").keyup(function(){
			if( $("#password").val() != "")
				if( $("#password").val() == $("#passwordcheck").val()) { // 둘 다 똑같이 입력했으면
					$("#passwordChkMsg").html("비밀번호가 일치합니다.").css("color", "green");
					$("#passwordResult").val("true");
				} else { // 다르게 입력했으면
					$("#passwordChkMsg").html("비밀번호가 일치하지 않습니다.").css("color", "red");
					$("#passwordResult").val("false");
				}
		});
	});
	
	function formCheck(){
		if($("#passwordResult").val()=="false"){
			alert("비밀번호를 확인하세요!");
			return false;
		}
	}
	
	//유저생성
	function userCreate() {
		$("#btnIns").on("click", function() {
		
			
			if( $("#password").val() != $("#passwordcheck").val()){
				alert("비밀번호를 확인하세요!");
				return 
			}
			var param = JSON.stringify($('#frm2').serializeObject()); 
			$.ajax({
				url : "users",
				type : 'POST',
				dataType : 'json',
				data : param,
				contentType : 'application/json',
				success : function(response) {
					if (response.result == true) {
						location.href = "userList"
					}
				},
				error : function(xhr, status, message) {
					alert(" status: " + status + " er:" + message);
				}
			});
		});//등록 버튼 클릭
	}//userInsert
	
	// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	
	function idCheckFunction(){
		$("#id").blur(function() {
			// id = "id_reg" / name = "userId"
			var id = $('#id').val();
			id = id.toUpperCase();
			$("#id").val(id);
			
			$.ajax({
				url : '${pageContext.request.contextPath}/idCheck?id='+ id,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 ");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					}else {
						 if(id == ""){
							
							$('#id_check').text('아이디를 입력해주세요');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
						  
						} else{
							$("#id_check").text("사용가능한 아이디입니다.");
							$('#id_check').css('color', 'blue');
							$("#reg_submit").attr("disabled", false);
						}
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
	}
</script>
<div class = "container">
<div class="form-group">
	<form action="userList.jsp" id="frm2">
		<table class = "table table-borderless">
			<tr>
				<td>스키마아이디</td>
				<td>
					<input type="text" name="id" id="id" placeholder="ID" maxlength="50" required
						class="form-control" >
					<div class="check_font" id="id_check"></div> 
				</td> 
			</tr>

		 	<tr>
				<td>비밀번호*</td>
				<td>
					<input type="password" name="password" id="password" placeholder="PASSWORD" maxlength="50" required
						class = "form-control">
				</td>
			</tr>

			<tr>
				<td>비밀번호 확인*</td>
				<td>
					<input type="password" name="passwordcheck" id="passwordcheck" placeholder="PASSWORD" maxlength="50" required
						class = "form-control">
					<span id = "passwordChkMsg"> </span>
				</td>
			</tr>
			<tr>
				<td>
					default tablespace
				</td>
				<td>
					<select name="defaultTableSpace" class = "form-control">
					<c:forEach var = "list" items="${tableSpaceList}">
					<option value="${list.tablespaceName}">${list.tablespaceName}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td>
					<input type="radio" name="accountStatus" value="lock" id = "statusLock" />
					<label class="form-check-label" for="statusLock">lock</label>
				</td>
				<td>
					<input type="radio" name="accountStatus" value="unlock" id = "statusUnlock" checked />
					<label class="form-check-label" for="statusUnlock">unlock</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="btnIns" class = "btn btn-block btn-outline-info">
						생성
					</button>
					<button type="button" class = "btn btn-block btn-outline-secondary" onclick = "history.back()">
						뒤로가기
					</button>
				</td>
			</tr>
		</table>
	
		
	</form>
</div>
</div>
</body>
</html>