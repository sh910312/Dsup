<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
			alert("비밀번호를 확인하세요");
			return false;
		}
	}
	
	//유저생성
	function userCreate() {
		var id = $('#id').val();
		var idChkYn = false;
		id = id.toUpperCase();
		$("#id").val(id);
		userCreate.isLoad = false;

		$("#btnIns").on("click", function() {
			console.log(id);
			if($("#id").val() == "" ){
				alert("아이디를 확인하세요!");
				return
			}
			if (idChkYn == false){
				alert("아이디 중복체크하세요")
				return
			}
			if( $("#password").val() != $("#passwordcheck").val()){
				alert("비밀번호를 확인하세요!");
				return 
			}
			if( $("#defaultTableSpace").val() == "" ){
				alert("defaultTableSpace를 확인하세요!")
				return
			}

			var param = JSON.stringify($('#frm2').serializeObject()); 
			if(userCreate.isLoad != true) {
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
			}); // ajax
			userCreate.isLoad = true;
			}
		});//등록 버튼 클릭
	}//userInsert
	
	
 	//아이디 유효성 검사(1 = 중복 / 0 != 중복)
	function idCheckFunction(){
		$("#id").blur(function() {
			// id = "id_reg" / name = "userId"
			var id = $('#id').val();
			id = id.toUpperCase();
			$("#id").val(id);

			 if(id == ""){				
				$('#id_check').text('아이디를 입력해주세요');
				$('#id_check').css('color', 'red');
				$("#reg_submit").attr("disabled", true);				
			  return
			} if(!id.substr(0,1).match(/[A-Z]/)) {
				$('#id_check').text('사용할 수 없는 문자입니다.');
				$('#id_check').css('color', 'red');
				$("#reg_submit").attr("disabled", true);
				return
			} 
			idChkYn = false;
			$.ajax({
				url : '${pageContext.request.contextPath}/idCheck?id='+ id,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : 2 = 키워드o"+ data);							
				      

					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 ");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
						return
					}   
					else if (data == 2) {
						$("#id_check").text("예약어는 사용할 수 없습니다. ");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
						return
						
					}else{
						$("#id_check").text("사용가능한 아이디입니다.");
						$('#id_check').css('color', 'blue');
						$("#reg_submit").attr("disabled", false);
						idChkYn = true
					}
				}, error : function() {
						console.log("실패");
						}
		
			
				}) // ajax
			
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
					<input type="text" name="id" id="id" placeholder="ID" size="30" maxlength="12" required
						class="form-control" >
					<div class="check_font" id="id_check"></div>
				</td> 
			</tr>

		 	<tr>
				<td>비밀번호*</td>
				<td>
					<input type="password" name="password" id="password" size="30" placeholder="PASSWORD" maxlength="15" required
						class = "form-control">
				</td>
			</tr>

			<tr>
				<td>비밀번호 확인*</td>
				<td>
					<input type="password" name="passwordcheck" id="passwordcheck" size="30" placeholder="PASSWORD" maxlength="15" required
						class = "form-control">
					<span id = "passwordChkMsg"> </span>
				</td>
			</tr>
			<tr>
				<td>
					default tablespace
				</td>
				<td>
					<select name="defaultTableSpace" id="defaultTableSpace" class = "form-control">
					<c:forEach var = "list" items="${tableSpaceList}">
					<option value="${list.tablespaceName}">${list.tablespaceName}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td>
					<br>잠금여부
				</td>
				<td>
					<input type="radio" name="accountStatus" value="lock" id = "statusLock"/>
					<label class="form-check-label" for="statusLock">lock</label><br><br>
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