<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/json.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		userList(); //userList조회
		userDelete(); //user삭제
		userUpdate();
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
					$('<td>').html('<button id="btnDelete">삭제')).append(
					$('<td>').html('<button id="btnUpdate">수정')).append( 
					$('<input type="hidden" id="hidden_userId">').val(
							item.USERNAME)).appendTo('#userList');
			// <input type = "hidden" id = "hidden_userId" value="item.USERNAME">
		});
	}

	//삭제
	function userDelete() {
		$('body').on('click', '#btnDelete', function() {
			var userId = $(this).closest('tr').find('#hidden_userId').val(); //선택한것에 val 값을 가져오겠다
			var result = confirm(userId + "삭제하시겠습니까?");
			if(result){
				$.ajax({
					url:'users/'+userId,
					type:'DELETE',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					error:function(xhr,status,msg){
						console.log("상태값:" + status + " Http에러메세지: " + msg);
					},  success:function(xhr){
						console.log(xhr.result);
						userList();
					}
				});
			}
		});
	}
	var dialog, form;
	 $( function() {
		    
		 
		      // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		      emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
		      id = $( "#id" ),
		      /* email = $( "#email" ),
		      password = $( "#password" ), */
		      allFields = $( [] ).add( id ),//.add( email ).add( password ),
		      tips = $( ".validateTips" );
		 
		    function updateTips( t ) {
		      tips
		        .text( t )
		        .addClass( "ui-state-highlight" );
		      setTimeout(function() {
		        tips.removeClass( "ui-state-highlight", 1500 );
		      }, 500 );
		    }
		 
		    function checkLength( o, n, min, max ) {
		      if ( o.val().length > max || o.val().length < min ) {
		        o.addClass( "ui-state-error" );
		        updateTips( "Length of " + n + " must be between " +
		          min + " and " + max + "." );
		        return false;
		      } else {
		        return true;
		      }
		    }
		 
		    function checkRegexp( o, regexp, n ) {
		      if ( !( regexp.test( o.val() ) ) ) {
		        o.addClass( "ui-state-error" );
		        updateTips( n );
		        return false;
		      } else {
		        return true;
		      }
		    }
		 
		    function addUser() {
		      var valid = true;
		      allFields.removeClass( "ui-state-error" );
		 
		      valid = valid && checkLength( id, "username", 3, 16 );
		      /* valid = valid && checkLength( email, "email", 6, 80 );
		      valid = valid && checkLength( password, "password", 5, 16 ); */
		 
		      valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
		      valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
		      valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
		 
		      if ( valid ) {
					var id = $('input:text[name="id"]').val();
					$.ajax({
						url: "users",
						type: 'PUT',
						dataType: 'json',
						data: JSON.stringify({ id: id}),
						contenType: 'application/json',
						success: function(data){
							//userList();
							dialog.dialog( "close" );
						},
						error:function(xhr, status, message){
							alert(" status: " + status + "er:" + message);
						}
					});
		        
		      }
		      return valid;
		    }
		 
		    dialog = $( "#dialog-form" ).dialog({
		      autoOpen: false,
		      height: 400,
		      width: 350,
		      modal: true,
		      
		      buttons: {
		        "수정": addUser,
		     	   취소: function() {
		          dialog.dialog( "close" );
		        }
		      },
		      close: function() {
		        form[ 0 ].reset();
		        allFields.removeClass( "ui-state-error" );
		      }
		    });
		 
		    form = dialog.find( "form" ).on( "submit", function( event ) {
		      event.preventDefault();
		      addUser();
		    });
		 

		  } );
 	//수정
	function userUpdate(){
		$('body').on('click','#btnUpdate',function(){
			var userId = $(this).closest('tr').find('#hidden_userId').val();
			dialog.dialog( "open" );
			$("#name").val(userId)

		});
	} 
</script>
</head>
<body>
<div id="dialog-form" >
  <p class="validateTips"></p>
 
  <form>
    <fieldset>
      <label for="id">id</label>
      <input type="text" name="id" id="name"  class="text ui-widget-content ui-corner-all">
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
      
      <label for="password">Password</label>
      <input type="password" name="password" id="password" class="text ui-widget-content ui-corner-all">"
      
       <label for="password">passwordCheck</label>
      <input type="password" name="passwordCheck" id="password" class="text ui-widget-content ui-corner-all">
    </fieldset>
  </form>
</div>
 
	<div class="container">
		<h2>User 목록</h2>
		<table class="table text-center">
			<thead>
				<tr>
					<th>아이디</th>
				</tr>
			</thead>
			<tbody id="userList">
			</tbody>
		</table>
	</div>

	
</body>
</html>