$(function(){
		memberInsert();	//등록버튼 이벤트지정
		
		memberDelete();	//삭제
	
		memberUpdate();	//수정
		
		checkValue();
});

function checkValue(){	
	
	$('#login-userId, #login-password').keyup(function(){
		$(this).next().next().next().empty();
	});
	
	$('#checkValue').on('click', function(){
		if($('#login-userId').val() == ''){
			$('[for="userId"]').next().text("아이디를 입력해주세요.");
		}
		if($('#login-password').val() == ''){
			$('[for="password"]').next().text("비밀번호를 입력해주세요.");
			return false
		}	
		
	});
}	
			
//사용자 등록요청
function memberInsert(){
	//등록버튼클릭
	$('#userId, #password, #nickname, #email, #phonenumber').keyup(function(){
		$(this).next().next().next().empty();
	});
	$('#btnInsert').on('click', function(){
		var err = 0;
		if($('#userId').val() == ''){
			$('[for="userId"]').next().text("아이디를 입력해주세요.");
			err++;
		}
		if($('#password').val() == ''){
			$('[for="password"]').next().text("비밀번호를 입력해주세요.");
			err++;
		}
		if($('#nickname').val() == ''){
			$('[for="nickname"]').next().text("닉네임을 입력해주세요.");
			err++;
		}	
		if($('#email').val() == ''){
			$('[for="email"]').next().text("이메일을 입력해주세요.");
			err++;
		}	
		if($('#phonenumber').val() == ''){
			$('[for="phonenumber"]').next().text("전화번호를 입력해주세요.");
			err++;
		}	
		if (err == 0) {
		var param = JSON.stringify($("#register-form").serializeObject());	//단건일때 //다건일땐 변환애줘야됨
		$.ajax({
			url: "members",
			type: 'POST',
			dataType: 'json',
			data: param, //JSON.stringify({id: id, name:name, password: password, role: role}),
			contentType: 'application/json',
			success: function(response){
				$('[class="form__error"]').text('');
				if(response.result == true){	// 서버에서 등록후에 true라고 넘어오면
					location.href='login';
				}else{
					if(response.idcheck==true){
						$('[for="userId"]').next().text("이미 사용중인 아이디입니다.");
					}else if(response.passwordcheck==true){
						$('[for="password"]').next().text("비밀번호가 다릅니다.");
					}
				}
			},
			/*error:function(xhr, status, message){
				alert(" status: " + status + " er:"+message);
			}*/
		}); // ajax
		err++;
		}
	});//등록버튼클릭
}//userInsert
 	//사용자 삭제 요청
function memberDelete() {
	//삭제 버튼 클릭
	$('body').on('click','#btnDelete',function(){
		var userId = $(this).closest('tr').find('#hidden_userId').val();
		var result = confirm(userId +" 사용자를 정말로 삭제하시겠습니까?");
		if(result) {
			$.ajax({
				url:'memebers/'+userId,  
				type:'DELETE',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				error:function(xhr,status,msg){
					console.log("상태값 :" + status + " Http에러메시지 :"+msg);
				}, success:function(xhr) {
					console.log(xhr.result);
					memberList();
				}
			});      }//if
	}); //삭제 버튼 클릭
}//userDelete 


//사용자 수정 요청
function memberUpdate() {
	//수정 버튼 클릭
	$('#btnUpdate').on('click',function(){
		var userId = $('input:text[name="userId"]').val();
		var nickname = $('input:text[name="nickname"]').val();
		var password = $('[name="password"]').val();
		var eMail = $('[name="eMail"]:checked').val();
		var phonenumber = $('[name="phonenumber"]:checked').val();	
		$.ajax({ 
		    url: "members", 
		    type: 'PUT', 
		    dataType: 'json', 
		    data: JSON.stringify({ userId: userId, nickname: nickname,password: password, eMail: eMail, phonenumber: phonenumber }),
		    contentType: 'application/json',
		    success: function(data) { 
		        memberList();
		    },
		    error:function(xhr, status, message) { 
		        alert(" status: "+status+" er:"+message);
		    }
		});
	});//수정 버튼 클릭
}//userUpdate





