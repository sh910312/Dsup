$(function(){
		memberList();	//목록조회
		
		memberInsert();	//등록버튼 이벤트지정
		
		memberSelect();	//조회
			
		memberDelete();	//삭제
	
		memberUpdate();	//수정
		
		checkValue()
});
function checkValue(){	
	$('#checkValue').on('click', function(){
		var userId = $("userId").val();
		$('[class="form__error"]').text('');
		if (userId.length < 1){
			$('[for="userId"]').next().text("다른 아이디를 사용해주세요.");
		
		}
	})	
  
}	
			/*$.ajax({
				url: "members",
				type: 'POST',
				dataType: 'json',
				data: param, 
				contentType: 'application/json',
				success: function(response){
					$('[class="form__error"]').text('');
					if(response.result == true){	// 서버에서 등록후에 true라고 넘어오면
						location.href='login';
					}else{
						if(response.idcheck==true){
							$('[for="userId"]').next().text("다른 아이디를 사용해주세요.");
						}else if(response.passwordcheck==true){
							$('[for="password"]').next().text("비밀번호가 다릅니다.");
						}
*/
//사용자 등록요청
function memberInsert(){
	//등록버튼클릭
	$('#btnInsert').on('click', function(){
		var id = $('input:text[name="userId"]').val();
		/*var nickname= $('input:text[name="nickname"]').val();
		var password = $('[name="password"]').val();
		*/
		
		 if(id == "") {
			 alert("아이디를 입력하세요");
			
		 }
		 /*if(new String(nickname).valueOf() == "undefined") return true;
		 if(new String(password).valueOf() == "undefined") return true;*/

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
						$('[for="userId"]').next().text("다른 아이디를 사용해주세요.");
					}else if(response.passwordcheck==true){
						$('[for="password"]').next().text("비밀번호가 다릅니다.");
					}
				}
			},
			error:function(xht, status, message){
				alert(" status: " + status + " er:"+message);
			}
		});
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

//사용자 조회 요청
function memberSelect() {
	//조회 버튼 클릭
	$('body').on('click','#btnSelect',function(){	//body 에 위임해준이유  
		var userId = $(this).closest('tr').find('#hidden_userId').val();
		//특정 사용자 조회
		$.ajax({
			url:'members/'+userId,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			error:function(xhr,status,msg){
				alert("상태값 :" + status + " Http에러메시지 :"+msg);
			},
			success:userSelectResult
		});
	}); //조회 버튼 클릭
}//userSelect

//사용자 조회 응답
function memberSelectResult(member) {
	$('input:text[name="userId"]').val(member.userId);
	$('input:text[name="nickname"]').val(member.nickname);
	$('[name="password"]').val(member.password);
	$('[name="eMail"]').val([member.eMail]);//radio checkbox는 배열로 값을 넣어야한다	//.attr("selected", "selected")
	$('[name="phonenumber"]').val([member.phonenumber]);
}//userSelectResult

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

//사용자 목록 조회 요청
function memberList(){
	$.ajax({
		url:'members',
		type:'GET', 	//요청방식
		dataType:'json',	//결과데이터타입
		error:function(xhr, status, msg){
			alert("상태값 : "+status + " Http에러메세지 :"+msg);
		},
		success:memberListResult
	});
}
//사용자 목록 조회 응답
function memberListResult(data){	//data서버에서넘겨받은 json
	$('tbody').empty();
	$.each(data,function(idx,item){		//데이터안의 건수만큼 each돌아감
		$('<tr>').append($('<td>').html(item.userId))
				 .append($('<td>').html(item.nikcname))
				 .append($('<td>').html(item.password))
				 .append($('<td>').html(item.eMail))
				 .append($('<td>').html(item.phonenumber))
				 .append($('<td>').html('<button id=\'btnSelect\'>조회</button>'))
				 .append($('<td>').html('<button id=\'btnDelete\'>삭제</button>'))
				 .append($('<input type=\'hidden\' id=\'hidden_userId\'>').val(item.id))
				 .appendTo('tbody');
	});//each
}//userListResult



