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
		userCreate(); //user등록
		idCheckFunction(); //id체크 

	});
	//비밀번호 입력확인
	$(function(){
		$("#passwordcheck,#password").keyup(function(){
			if( $("#password").val() != "" )
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
		if($("$passwordResult").val()=="false"){
			alert("비밀번호를 확인하세요!");
			return false;
		}
	}
	//유저생성
	function userCreate() {
		$("#btnIns").on("click", function() {
			var param = JSON.stringify($('#frm').serializeObject());
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
			$.ajax({
				url : '${pageContext.request.contextPath}/idCheck?id='+ id,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						 if(id == ""){
							
							$('#id_check').text('아이디를 입력해주세요 :)');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else{
							$("#id_check").text("");
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
</head>
<body>
<div class="form-group">
	<form action="userList.jsp" id="frm">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" class="form-control" name="id" id="id" placeholder="ID" maxlength="50" required>
				<div class="check_font" id="id_check"></div> 
				</td> 
			</tr>

		 	<tr>
				<td>비밀번호*</td>
				<td><input type="password" name="password" id="password" placeholder="PASSWORD" maxlength="50" required>
				</td>
			</tr>

			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="passwordcheck" id="passwordcheck" placeholder="PASSWORD" maxlength="50" required>
				<span id = "passwordChkMsg"> </span>
				</td>
			</tr>
			<tr>
				<td>default tablespace</td>
				<td><select name="defaultTableSpace">
				<option value="USERS">USERS</option>
				<option value="UNDOTBS1">UNDOTBS1</option>
				<option value="TEMP">TEMP</option>
				<option value="SYSTEM">SYSTEM</option>
				<option value="SYSAUX">SYSAUX</option>
				<option value="FDA_TBS">FDA_TBS</option>
				<option value="DATA_2K_TBS">DATA_2K_TBS</option>
				</select>
			</tr>
			<tr>
				<td><input type="radio" name="accountStatus" value="lock" checked/>lock</td>
				<td><input type="radio" name="accountStatus" value="unlock"/>unlock</td>
			</tr>
		</table>
	
		<button type="button" id="btnIns">생성</button>
	</form>
</div>
</body>
</html>