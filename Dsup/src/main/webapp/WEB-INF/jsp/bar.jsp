<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix='c' %>
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
	<!-- ↓ DB헬퍼 아이콘 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<!-- 메뉴바 시작 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="./main">
    	<i class="fa fa-database" aria-hidden="true" style="margin-right: 10px"></i>
		<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
		<circle cx="12" cy="13" r="4"></circle>
    	<strong>DBhelper</strong>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExample07">
    <!-- ↓ 윤정 DB관리 바 들어올 부분 -->
 	<ul class="navbar-nav mr-auto" id = "DBbar">
 	</ul>
	<!-- ↑ 윤정 DB관리 바 들어올 부분 -->
      
    <div class = "col-auto">
      <form class="form-inline my-2 my-md-0">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown07" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">menu</a>
          <div class="dropdown-menu" aria-labelledby="dropdown07">
          	<c:if test = "${userType=='2'}">
            	<a class="dropdown-item" href="./admin">관리자메뉴</a>
            </c:if>
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#myInfoModal">내 정보</a>
            <a class="dropdown-item" href="./logout">로그아웃</a>
          </div>
        </li>
      </ul>
      </form>
      </div>
    </div>
  </div>
</nav>
<!-- 메뉴바 끝	 -->
	
	
<!-- 회원 정보 Modal -->
<div class="modal fade" id="myInfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">내 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	아이디: ${member.userId}<br>
			닉네임: <span id="infoNickname">${member.nickname}</span><br>
			이메일: <span id="infoEMail">${member.eMail}</span><br>
			전화번호: <span id="infoPhonenumber">${member.phonenumber}</span><br>
			가입날짜: <fmt:parseDate value="${member.userDate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
				    <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/><br>
			<br><br>
      </div>
      <div class="modal-footer">
        <button id = "myBtn" class = "btn btn-info"  data-dismiss="modal"
        	data-toggle="modal" data-target="#modifyModal">정보변경</button>
		<button id = "withdrawGo" class = "btn btn-secondary" data-dismiss="modal"
			 data-toggle="modal" data-target="#withdrawalModal">회원탈퇴</button>
      </div>
    </div>
  </div>
</div>

<!-- 회원 정보 수정 Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원 정보 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<form name="frm" action="">
			<div class="form-group">
				<label for="mdifyId">아이디</label>
				<input class="form-control-plaintext" id="mdifyId" readonly value = "${member.userId}">
			</div>
			<div class="form-group">
				<label for="mdifyPassword">비밀번호</label>
				<input name="password"  id="mdifyPassword" value = "${member.password}" class="form-control">
			</div>
			<div class="form-group">
				<label for="mdifyNickname">닉네임</label>
				<input name="nickname"  id="mdifyNickname" value = "${member.nickname}" class="form-control">
			</div>
			<div class="form-group">
				<label for="mdifyEmail">이메일</label>
				<input name="eMail"  id="mdifyEmail" value = "${member.eMail}" class="form-control">
			</div>
			<div class="form-group">
				<label for="mdifyTel">전화번호</label>
				<input name="phonenumber"  id="mdifyTel" value = "${member.phonenumber}" class="form-control">
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <form name="withdrawalFrm" action="">
			<button type="button" id="btnUpdate" class = "btn btn-info" data-dismiss="modal"
				 data-toggle="modal" data-target="#myInfoModal">수정완료</button>
		</form>
      </div>
    </div>
  </div>
</div>

<!-- 윤정 회원 탈퇴 Modal -->
<div class="modal fade" id="withdrawalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원탈퇴</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div id = "withdrawalMsg">
			<h4>회원 탈퇴 정책</h4>
			1. 회원 탈퇴 일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임/휴대폰번호)와 결제 정보는 '개인 정보 보호 정책'에 따라 30일간 보관(잠김) 되며, 30일이 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다. <br>
			2. 테이블스페이스와 유저 스키마, 백업파일은 탈퇴 즉시 모두 삭제되며 복구가 불가능합니다.<br>
			<br>
		</div>
      </div>
      <div class="modal-footer">
      	<button type="button" id="btnWithdrawal" class = "btn btn-info">탈퇴하기</button>
      </div>
    </div>
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
			if(response.result == true) { // result == true
				location.href = './withdrawalSuccess';
			} else { // result == false
				$("#withdrawalMsg").html(
					"<h4>탈퇴 실패</h4>" +
					"다시 시도해주세요."
				);
			}
		},
		error : function() {
			
		}
	});
}

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
		    },
		    error:function(xhr, status, message) { 
		        alert(" status: "+status+" er:"+message);
		    }
		});
	});//수정 버튼 클릭
}//userUpdate
</script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	memberUpdate();
	$("#btnWithdrawal").click(withdrawalFunc); // ← 윤정 탈퇴 신청 처리
	$(".dropdown-toggle").dropdown();
});
</script>
<%-- <!-- 채팅 영역 시작 -->
	<div class="pull-right col-xs-3">
<%-- 		<%@include file="./chat/chatMain.jsp"%> --%>
<!-- 채팅 영역 끝 --> 