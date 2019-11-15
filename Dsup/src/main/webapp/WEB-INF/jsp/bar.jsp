<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %> 
<style type="text/css">
		/* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
         .modal2 {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 20%; /* Could be more or less, depending on screen size */                          
        	height: 40%
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script type="text/javascript">
	function goPage(){
		var value = document.getElementById("menu").value;
		if(value == ""){
			return
		}
		if(value == "myInfo"){
			modal.style.display = "block";
			modify.style.display = "none";
		    myInfo.style.display = "block";
		    withdrawal.style.display = "none"; // 윤정 탈퇴양식
		}else{
			location.href=value			
		}
		document.getElementById("menu").selectedIndex=0;
	}
	
</script>
<nav>
<div style="text-align: right">
프로필<select id="menu" onchange="goPage()">
	<option value="">선택</option>
	<option value="admin">관리자</option>
	<option value="messge">쪽지함</option>
	<option value="chatMain">채팅봇</option>
	<option value="">Q &amp; A</option>
	<option value="myInfo">정보변경</option>
	<option value="logout">로그아웃</option>
</select>
</div>
</nav>

<!-- The Modal -->
    <div id="myModal" class="modal">
      <!-- Modal content -->
      <div class="modal-content">
	    <span class="close">&times;</span>                                                               
        <div id="myInfo">
	      	<h3>MyInfo</h3>
			아이디: ${member.userId}<br>
			닉네임: <span id="infoNickname">${member.nickname}</span><br>
			이메일: <span id="infoEMail">${member.eMail}</span><br>
			전화번호: <span id="infoPhonenumber">${member.phonenumber}</span><br>
			가입날짜: <fmt:parseDate value="${member.userDate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
				    <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/><br>
			<br><br><br><br><br><br><br>
			
			<button id="myBtn">정보변경</button>
			<button id = "withdrawGo">회원탈퇴</button>
		</div>
		<div id="modify">
		    <h3>Modify</h3>
		    <form name="frm" action="">
		      아이디: ${member.userId}<br>
		      비밀번호 : <input name="password"><br>
			닉네임: <input name="nickname"><br>
			이메일: <input name="eMail"><br>
			전화번호: <input name="phonenumber"><br>
			<button type="button" id="btnUpdate" >수정</button>
			</form>
		</div>
		<!-- ↓윤정1113 회원탈퇴 -->
		<div id="withdrawal">
			<h3>회원탈퇴</h3>
			<h4>회원 탈퇴 정책</h4>
			1. 회원 탈퇴 일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임/휴대폰번호)는 '개인 정보 보호 정책'에 따라 30일간 보관(잠김) 되며, 30일이 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다. <br>
			2. 테이블스페이스와 유저 스키마, 백업파일은 탈퇴 즉시 모두 삭제되며 복구가 불가능합니다.<br>
			<br>
			<form name="withdrawalFrm" action="">
			<button type="button" id="btnWithdrawal">탈퇴신청</button>
			</form>
		</div>
		<!-- ↑윤정 회원탈퇴 -->
      </div>
	</div>





<script type="text/javascript">
var modal = document.getElementById('myModal');
var myInfo = document.getElementById('myInfo');
var modify = document.getElementById('modify');
var btn = document.getElementById("myBtn");
var close = document.getElementsByClassName("close")[0]; 
var infoNickname = document.getElementById('infoNickname');
var infoEMail = document.getElementById('infoEMail');

modify.style.display = "none";

btn.onclick = function(){ // 정보변경 버튼 클릭
	modify.style.display = "block";
    myInfo.style.display = "none";
}
close.onclick = function() { // 닫기 버튼 클릭
    modal.style.display = "none";
}
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    	document.frm.reset();
    }
}
// ↓윤정 '회원탈퇴' 버튼 클릭시, 탈퇴 폼 보이게
$("#withdrawGo").click(function(){
	myInfo.style.display = "none";
	$("#withdrawal").toggle();
});
// ↓윤정 회원탈퇴 신청 처리
function withdrawalFunc(){
	var userId = "${userId}";
	console.log(JSON.stringify({userId:userId, userType:0, payService:'N'}));
	$.ajax({
		url: "memberWithdrawal",
		type : "PUT",
		dataType: 'json',
		data : JSON.stringify({userId:userId, userType:0, payService:'N'}),
		contentType : 'application/json',
		success : function(response) {
			if(response.result == true) {
					alert("성공!");
				} else {
					alert("실패!");
				}
		},
		error : function() {
			
		}
	});
}


$(function(){
	memberUpdate();
	$("#btnWithdrawal").click(withdrawalFunc); // ← 윤정 탈퇴 신청 처리
});
function memberUpdate() {
	//수정 버튼 클릭
	$('#btnUpdate').on('click',function(){
		var nickname = $('input:text[name="nickname"]').val();
		var password = $('[name="password"]').val();
		var eMail = $('[name="eMail"]').val();
		var phonenumber = $('[name="phonenumber"]').val();
		$.ajax({ 
		    url: "members", 
		    type: 'PUT', 
		    dataType: 'json', 
		    data: JSON.stringify({ nickname: nickname,password: password, eMail: eMail, phonenumber: phonenumber }),
		    contentType: 'application/json',
		    success: function(data) { 
			    infoNickname.innerHTML = document.frm.nickname.value
			    infoEMail.innerHTML = document.frm.eMail.value
			    infoPhonenumber.innerHTML = document.frm.phonenumber.value 
			    modify.style.display = "none";
			    myInfo.style.display = "block";
		    },
		    error:function(xhr, status, message) { 
		        alert(" status: "+status+" er:"+message);
		    }
		});
	});//수정 버튼 클릭
}//userUpdate
</script>


<!-- 채팅 영역 시작 -->
	<div class="pull-right col-xs-3">
		<%-- <%@include file="./chat/chatMain.jsp"%> --%>
	</div>
<!-- 채팅 영역 끝 --> 