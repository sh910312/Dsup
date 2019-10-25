<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/json.min.js"></script>
<script>
$(function(){
	userCreate();	//user등록

});

//유저생성
function userCreate(){
	$("#btnIns").on("click", function(){
		var param = JSON.stringify($('#frm').serializeObject());
		$.ajax({
			url: "users",
			type: 'POST',
			dataType: 'json',
			data: param,
			contentType: 'application/json',
			success: function(response){
				if(response.result == true){
					location.href="userList"
				}
			},
			error:function(xhr, status, message){
				alert(" status: " +status+" er:"+message);
			}
		});
	});//등록 버튼 클릭
}//userInsert


$(function idChk(){
	//아이디 중복체크
	    $('#id').blur(function(){
	        $.ajax({
		     type:"POST",
		     url:"checkSignup",
		     data:{
		            "id":$('#id').val()
		     },
		     success:function(data){	//data : checkSignup에서 넘겨준 결과값
		            if($.trim(data)=="YES"){
		               if($('#id').val()!=''){ 
		               	alert("사용가능한 아이디입니다.");
		               }
		           	}else{
		               if($('#id').val()!=''){
		                  alert("중복된 아이디입니다.");
		                  $('#id').val('');
		                  $('#id').focus();
		               }
		            }
		         }
		    }) 
	     })
	});
</script>
</head>
<body>
	<form action="userList.jsp" id="frm">
            <table>
                <tr>
                    <td id="id">이름</td>
                    <td>
                        <input type="text" name="id" maxlength="50">
                        <input type="button" value="ID 중복확인" onclick="idChk()">
                    </td>
                </tr>
                        
                <tr>
                    <td id="password">비밀번호</td>
                    <td>
                        <input type="password" name="password" maxlength="50">
                    </td>
                </tr>
                
                <tr>
                    <td id="password">비밀번호 확인</td>
                    <td>
                        <input type="password" name="passwordcheck" maxlength="50">
                    </td>
                </tr>
            </table>
            <button type="button" id="btnIns">생성</button>
	</form>

</body>
</html>