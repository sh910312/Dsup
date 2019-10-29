<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="./resources/json.min.js"></script>
<script>
	$(function(){
		memberList();		//목록조회
		memberInsert();	//등록버튼 이벤트지정
		
		memberSelect();	//조회
			
		memberDelete();	//삭제
	
		memberUpdate();	//수정
	});
	
	
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
	}//userSelectResult
	
	//사용자 수정 요청
	function memberUpdate() {
		//수정 버튼 클릭
		$('#btnUpdate').on('click',function(){
			var userId = $('input:text[name="userId"]').val();
			var nickname = $('input:text[name="nickname"]').val();
			var password = $('[name="password"]').val();
			var eMail = $('[name="eMail"]:checked').val();	
			$.ajax({ 
			    url: "members", 
			    type: 'PUT', 
			    dataType: 'json', 
			    data: JSON.stringify({ userId: userId, nickname: nickname,password: password, eMail: eMail }),
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
	
	
	
	
	
	//사용자 등록요청
	function memberInsert(){
		//등록버튼클릭
		$('#btnInsert').on('click', function(){
			/* var id = $('input:text[name="id"]').val();
			var name= $('input:text[name="name"]').val();
			var password = $('[name="password"]').val();
			var role = $('[name="role"]:checked').val(); */		// $('[name="role"]').val(); 첫번째radio 가져옴	// :checked해야 선택한애가져옴
			
			var param = JSON.stringify($("#form1").serializeObject());	//단건일때 //다건일땐 변환애줘야됨
			$.ajax({
				url: "members",
				type: 'POST',
				dataType: 'json',
				data: param, //JSON.stringify({id: id, name:name, password: password, role: role}),
				contentType: 'application/json',
				success: function(response){
					if(response.result == true){	// 서버에서 등록후에 true라고 넘어오면
						memberList();
					}
				},
				error:function(xht, status, message){
					alert(" status: " + status + " er:"+message);
				}
			});
		});//등록버튼클릭
	}//userInsert
	
	
	
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
					 .append($('<td>').html('<button id=\'btnSelect\'>조회</button>'))
					 .append($('<td>').html('<button id=\'btnDelete\'>삭제</button>'))
					 .append($('<input type=\'hidden\' id=\'hidden_userId\'>').val(item.id))
					 .appendTo('tbody');
		});//each
	}//userListResult

</script>


</head>
<body>
	<div class="container">
		<form id="form1">
		  <div class="form-group row">
		    <label for="inputEmail3" class="col-sm-2 col-form-label">UserID</label>
		    <div class="col-sm-10">
		      <input type="text" name="userId" class="form-control" id="inputEmail3" placeholder="UserID">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" name="password" id="inputPassword3" placeholder="Password">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword3" class="col-sm-2 col-form-label">Nickname</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="nickname" id="inputPassword3" placeholder="Nickname">
		    </div>
		  </div>
		  <fieldset class="form-group">
		    <div class="row">
		      <legend class="col-form-label col-sm-2 pt-0"></legend>
		      <div class="col-sm-10">
		        <div class="form-check">
		          <input class="form-check-input" type="radio" name="role" id="gridRadios1" value="Admin" checked>
		          <label class="form-check-label" for="gridRadios1">
		            	관리자
		          </label>
		        </div>
		        <div class="form-check">
		          <input class="form-check-input" type="radio" name="role" id="gridRadios2" value="member">
		          <label class="form-check-label" for="gridRadios2">
		            	사용자
		          </label>
		        </div>
		        
		      </div>
		    </div>
		  </fieldset>
		  <div class="form-group row">
		    <div class="col-sm-10">
		      <button type="button" id="btnInsert" class="btn btn-primary">Sign in</button>
		      <input type="button"  class="btn btn-primary" value="수정"  id="btnUpdate" />
			  <input type="button"  class="btn btn-primary" value="초기화" id="btnInit" />
		    </div>
		  </div>
		</form>
	</div>

	<div class="container">
		<h2>사용자 목록</h2>	
		<table class="table text-center">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>패스워드</th>
					<th>롤</th>
				</tr>
			</thead>
			<tbody>
		
			</tbody>
		</table>
	</div>

</body>
</html>